import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';
import 'package:strawberryhrm/presentation/home/notification/schedule_notification.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

typedef HomeBlocFactory = HomeBloc Function();

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final LogoutUseCase logoutUseCase;
  final HomeDataLoadUseCase homeDatLoadUseCase;
  final SettingsDataLoadUseCase settingsDataLoadUseCase;
  final OfflineAttendanceRepository offlineAttendanceRepo;
  final EventBus eventBus;
  final StreamLocationUseCase streamLocationUseCase;

  HomeBloc({
    required this.logoutUseCase,
    required this.homeDatLoadUseCase,
    required this.settingsDataLoadUseCase,
    required this.eventBus,
    required this.offlineAttendanceRepo,
    required this.streamLocationUseCase,
  }) : super(const HomeState()) {
    ///Assign the appTheme at init contractor so that
    ///view can load more first(data from last state)
    globalState.set(dashboardStyleId, state.settings?.data?.appTheme);

    ///-----------------------------------------------------------///
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
    on<OnSwitchPressed>(_onSwitchPressed);
    on<OnLocationEnabled>(_onLocationEnabled);
    on<OnLocationRefresh>(_onLocationRefresh);
    on<OnResetEvent>(_onResetState);

    Timer.periodic(const Duration(minutes: 2), (_) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });

    eventBus.on<OfflineDataSycEvent>().listen((data) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });
  }

  bool isCheckedIn = false;
  bool isCheckedOut = false;

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }
    final data = await settingsDataLoadUseCase();
    data.fold(
      (l) {
        if (l.failureType == FailureType.httpStatus) {
          if ((l as GeneralFailure).httpStatusCode == 401) {
            logoutUseCase();
          }
        }
        emit(state.copy(status: NetworkStatus.failure));
      },
      (settings) {
        globalState.set(isHR, settings?.data?.isHr);
        globalState.set(isAdmin, settings?.data?.isAdmin);
        globalState.set(dashboardStyleId, settings?.data?.appTheme);
        globalState.set(isLocation, settings?.data?.locationService);
        globalState.set(notificationChannels, settings?.data?.notificationChannels);

        ///Assign default shift in pref
        if (settings != null) {
          if (settings.data!.shifts.isNotEmpty) {
            SharedUtil.setIntValue(shiftId, settings.data?.shifts.first.shiftId);
          }
        }
        subscribeTopic();
        emit(state.copy(settings: settings, status: NetworkStatus.success));
      },
    );
  }

  Future subscribeTopic() async {
    final notifications = globalState.get(notificationChannels);
    try {
      if (notifications != null) {
        for (var topic in notifications) {
          await FirebaseMessaging.instance.subscribeToTopic(topic);
          debugPrint("Firebase topics: $topic");
        }
      }
    } catch (_) {
      return;
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }

    final date = getDateAsString(dateTime: DateTime.now(), format: 'yyyy-MM-dd');
    isCheckedIn = await offlineAttendanceRepo.isAlreadyInCheckedIn(date: date);
    isCheckedOut = await offlineAttendanceRepo.isAlreadyInCheckedOut(date: date);
    final localAttendanceData = await offlineAttendanceRepo.getCheckDataByDate(date: date);

    final data = await homeDatLoadUseCase();
    data.fold(
      (l) {
        if (l.failureType == FailureType.httpStatus) {
          if ((l as GeneralFailure).httpStatusCode == 401) {
            logoutUseCase();
          }
        }
        emit(state.copy(status: NetworkStatus.failure));
      },
      (r) async {
        AttendanceData? attendanceData = r?.data?.attendanceData;
        final isBreakTaken =
            r?.data?.config?.breakStatus?.breakTime != null && r?.data?.config?.breakStatus?.backTime == null;

        ///Schedule check-in notification
        checkInScheduleNotification(
          r?.data?.config?.dutySchedule?.listOfStartDatetime ?? [],
          r?.data?.config?.dutySchedule?.listOfEndDatetime ?? [],
        );

        ///Initialize attendance data into global state
        globalState.set(attendanceId, attendanceData?.id);
        globalState.set(inTime, r?.data?.attendanceData?.inTime);
        globalState.set(outTime, r?.data?.attendanceData?.outTime);
        globalState.set(stayTime, r?.data?.attendanceData?.stayTime);

        ///Initialize break data into global state
        globalState.set(breakTime, r?.data?.config?.breakStatus?.breakTime);
        globalState.set(backTime, r?.data?.config?.breakStatus?.backTime);
        globalState.set(isBreak, isBreakTaken);
        globalState.set(isLocation, r?.data?.config?.locationService);

        ///Initialize custom timer data [HOUR, MIN, SEC]
        final time = getFormatTime(duration: r?.data?.config?.breakStatus?.duration ?? '00:00:00');
        globalState.set(hour, '${time.hour}');
        globalState.set(min, '${time.min}');
        globalState.set(sec, '${time.sec}');

        final bool isLocationEnabled = globalState.get(isLocation);

        ///------------------------Refresh data in OfflineAttendanceCubit-------------------------------------
        if (attendanceData?.id != null) {
          ///we can remove below line of code but before remove, verification needed
          final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
          final body = AttendanceBody(attendanceId: attendanceData?.id, inTime: attendanceData?.inTime, date: date);
          eventBus.fire(OnOnlineAttendanceUpdateEvent(body: body));
          // offlineAttendanceRepo.getCheckDataByDate(date: date).then((data){
          //   final body = data != null
          //       ? data.copyWith(attendanceId: attendanceData?.id, inTime: attendanceData?.inTime,outTime: null)
          //       : AttendanceBody(attendanceId: attendanceData?.id, inTime: attendanceData?.inTime,date: date);
          //   eventBus.fire(OnOnlineAttendanceUpdateEvent(body: body));
          // });
        } else {
          offlineAttendanceRepo.getCheckDataByDate(date: date).then((data) {
            final body = AttendanceBody();
            eventBus.fire(OnOnlineAttendanceUpdateEvent(body: body));
          });
        }

        _onOfflineDataSync();

        emit(
          state.copy(
            dashboardModel: r,
            gridMenus: filterManus(dashboardModel: r, isGrid: true),
            listMenus: filterManus(dashboardModel: r, isGrid: false),
            status: NetworkStatus.success,
            isSwitched: isLocationEnabled,
          ),
        );
      },
    );

    ///today's data available in local so we need to update in/out time from there
    if (localAttendanceData != null) {
      globalState.set(inTime, localAttendanceData.inTime);
      globalState.set(outTime, localAttendanceData.outTime);
    }
  }

  TimeBreak getFormatTime({required String duration}) {
    final splits = duration.split(':');
    return TimeBreak(hour: int.parse(splits[0]), min: int.parse(splits[1]), sec: int.parse(splits[2]));
  }

  void _onOfflineDataSync() async {
    final today = getDateAsString(dateTime: DateTime.now(), format: 'yyyy-MM-dd');
    isCheckedOut = await offlineAttendanceRepo.isAlreadyInCheckedOut(date: today);
    late Map<String, dynamic> body;
    if (isCheckedOut) {
      body = await offlineAttendanceRepo.getAllCheckInOutDataMap();
    } else {
      body = await offlineAttendanceRepo.getPastCheckInOutDataMap(today: today);
    }
    if (body['data'].isNotEmpty) {
      final isSynced = await instance<MetaClubApiClient>().offlineCheckInOut(body: body);
      isSynced.fold((l) {}, (r) {
        if (r) {
          if (isCheckedOut) {
            offlineAttendanceRepo.clearCheckOfflineData();
          } else {
            offlineAttendanceRepo.deleteFilteredCheckInOut(today: today);
          }
        }
      });
    }
  }

  void _onLocationRefresh(OnLocationRefresh event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: true));
    if (event.user != null) {
      add(OnLocationEnabled(user: event.user!));
    }
  }

  void _onSwitchPressed(OnSwitchPressed event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: !state.isSwitched));
    if (event.user != null) {
      add(OnLocationEnabled(user: event.user!));
    }
  }

  void _onLocationEnabled(OnLocationEnabled event, Emitter<HomeState> emit) {
    streamLocationUseCase(uid: '${globalState.get(companyId)}${event.user.id!}');
  }

  void _onResetState(OnResetEvent event, Emitter<HomeState> emit) {
    emit(const HomeState());
  }

  List<MultiShift> getMultiShift({required List<MultiShift>? shifts}) {
    if (shifts == null || shifts.isEmpty) return [];
    return shifts.toSet().toList();
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    SharedUtil.getBoolValue(isTokenVerified).then((isTokenVerified) {
      return HomeState.fromJson(json, isTokenVerified);
    });
    return HomeState.fromJson(json, true);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}

List<Menu> filterManus({DashboardModel? dashboardModel, required bool isGrid}) {
  if (dashboardModel == null) return [];
  if (isGrid) {
    final gridMenu = dashboardModel.data?.menus?.where((menu) => menuGrid.contains(menu.name)).toList();
    return gridMenu ?? [];
  }
  final listMenu = dashboardModel.data?.menus?.where((menu) => !menuGrid.contains(menu.name)).toList();
  return listMenu ?? [];
}

final menuGrid = ['Phonebook', 'Expense', 'Payroll', 'Attendance'];

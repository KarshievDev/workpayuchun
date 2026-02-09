import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';
import 'package:strawberryhrm/main.dart';
import 'offline_attendance_state.dart';

class OfflineCubit extends Cubit<OfflineAttendanceState> {
  final OfflineAttendanceRepository offlineAttendanceRepo;
  late StreamSubscription<OnOnlineAttendanceUpdateEvent> onlineSubscription;
  late StreamSubscription<OnOfflineAttendanceUpdateEvent> offlineSubscription;
  final EventBus eventBus;

  OfflineCubit({required this.offlineAttendanceRepo, required this.eventBus}) : super(const OfflineAttendanceState()) {
    onOnlineCheckInOutData();

    onlineSubscription = eventBus.on<OnOnlineAttendanceUpdateEvent>().listen((event) {
      updateHRMAppWidget(isCheckedIn: event.body.inTime != null && event.body.outTime == null);
      onOnlineCheckInOutData(body: event.body);
    });

    offlineSubscription = eventBus.on<OnOfflineAttendanceUpdateEvent>().listen((event) {
      onOfflineCheckInOutData(body: event.body);
    });
  }

  onOnlineCheckInOutData({AttendanceBody? body}) async {
    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    bool isCheckedIn = body?.inTime != null;
    bool isCheckedOut = body?.outTime != null;
    if (body != null) {
      if (isCheckedOut == true) {
        isCheckedIn = false;
        body = body.copyWith(attendanceId: null);
      }
      offlineAttendanceRepo.checkInOut(
            checkData: body,
            isCheckedIn: isCheckedIn,
            isCheckedOut: isCheckedOut,
            multipleAttendanceEnabled: true,
          ).then((_) async {
            AttendanceBody? localAttendanceData = await offlineAttendanceRepo.getCheckDataByDate(date: date);
            if (isCheckedOut && body?.isOffline == true) {
              ///-----------------------Try to sync attendance data with server when user try to checkout---------------
              eventBus.fire(const OfflineDataSycEvent());
            }

            ///--------------------------------------*********--------------------------------------------------------
            emit(
              state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData),
            );
          });
    } else {
      final localAttendanceData = await offlineAttendanceRepo.getCheckDataByDate(date: date);
      isCheckedIn = localAttendanceData?.attendanceId != null;
      isCheckedOut = localAttendanceData?.attendanceId == null;
      emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
    }
  }

  onOfflineCheckInOutData({AttendanceBody? body}) async {
    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    bool isCheckedIn = await offlineAttendanceRepo.isAlreadyInCheckedIn(date: date);
    bool isCheckedOut = await offlineAttendanceRepo.isAlreadyInCheckedOut(date: date);
    AttendanceBody? localAttendanceData = await offlineAttendanceRepo.getCheckDataByDate(date: date);

    if (body != null) {
      ///for offline attendance we need date, outTime, inTime
      if (isCheckedIn && isCheckedOut == false) {
        body = body.copyWith(inTime: localAttendanceData?.inTime);
        body = body.copyWith(outTime: DateFormat('h:mm a', 'en').format(DateTime.now()));
      } else {
        body = body.copyWith(inTime: DateFormat('h:mm a', 'en').format(DateTime.now()));
        body = body.copyWith(outTime: null);
      }

      offlineAttendanceRepo
          .offlineCheckInOut(
            checkData: body,
            isCheckedIn: isCheckedIn,
            isCheckedOut: isCheckedOut,
            multipleAttendanceEnabled: true,
          ).then((_) async {
            isCheckedIn = await offlineAttendanceRepo.isAlreadyInCheckedIn(date: date);
            isCheckedOut = await offlineAttendanceRepo.isAlreadyInCheckedOut(date: date);
            localAttendanceData = await offlineAttendanceRepo.getCheckDataByDate(date: date);
            if (localAttendanceData?.inTime != null) {
              isCheckedIn = true;
            }
            if (localAttendanceData?.outTime != null) {
              isCheckedOut = true;
              isCheckedIn = false;
            }
            if (localAttendanceData?.inTime != null && localAttendanceData?.outTime != null) {
              isCheckedIn = false;
              isCheckedOut = false;
            }
            emit(
              state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData),
            );
          });
    } else {
      emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
    }
  }

  @override
  Future<void> close() {
    onlineSubscription.cancel();
    offlineSubscription.cancel();
    return super.close();
  }
}

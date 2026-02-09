import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/view/appointment_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final MetaClubApiClient _metaClubApiClient;

  NotificationBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const NotificationState(
          status: NetworkStatus.initial,
        )) {
    on<LoadNotificationData>(_onNotificationDataLoad);
    on<RouteSlug>(_onRoutSlag);
    on<ClearNoticeButton>(_onClearData);
  }

  void _onNotificationDataLoad(
      LoadNotificationData event, Emitter<NotificationState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    final notificationResponse = await _metaClubApiClient.getNotification();
    notificationResponse.fold((l) {
      emit(const NotificationState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copy(
          notificationResponse: r,
          status: NetworkStatus.success));
    });
  }

  void _onRoutSlag(RouteSlug event, Emitter<NotificationState> emit) async {
    switch (event.slugName) {
      case 'daily_leave':
        break;
      // return NavUtil.navigateScreen(context, const DailyLeave());
      case 'leave_request':
        break;
      // return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'appointment_request':
        NavUtil.navigateScreen(event.context, const AppointmentScreen());
        break;
      default:
        return debugPrint('default');
    }
  }

  void _onClearData(
      ClearNoticeButton event, Emitter<NotificationState> emit) async {
    await _metaClubApiClient.clearAllNotificationApi();
  }
}

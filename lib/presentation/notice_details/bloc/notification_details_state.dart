part of 'notification_details_bloc.dart';

class NotificationDetailsState extends Equatable {
  final ResponseNoticeDetails? notificationResponse;
  final NetworkStatus status;
  final String? slugName;

  const NotificationDetailsState(
      {this.notificationResponse,
      this.slugName,
      this.status = NetworkStatus.initial});

  NotificationDetailsState copy(
      {BuildContext? context,
      ResponseNoticeDetails? notificationResponse,
      String? slugName,
      NetworkStatus? status}) {
    return NotificationDetailsState(
        notificationResponse: notificationResponse,
        status: status ?? this.status,
        slugName: slugName ?? this.slugName);
  }

  @override
  List<Object?> get props => [notificationResponse, slugName, status];
}

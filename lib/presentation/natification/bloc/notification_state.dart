part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NotificationDataModel? notificationResponse;
  final NetworkStatus status;
  final String? slugName;

  const NotificationState(
      {this.notificationResponse,
      this.slugName,
      this.status = NetworkStatus.initial});

  NotificationState copy(
      {BuildContext? context,
      NotificationDataModel? notificationResponse,
      String? slugName,
      NetworkStatus? status}) {
    return NotificationState(
        notificationResponse: notificationResponse,
        status: status ?? this.status,
        slugName: slugName ?? this.slugName);
  }

  @override
  List<Object?> get props => [notificationResponse, slugName, status];
}

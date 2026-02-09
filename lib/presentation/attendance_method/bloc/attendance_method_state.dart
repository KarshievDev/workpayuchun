part of 'attendance_method_bloc.dart';

class AttendanceMethodState extends Equatable {
  final NetworkStatus status;
  final String? slugName;

  const AttendanceMethodState({this.slugName, this.status = NetworkStatus.initial});

  AttendanceMethodState copy(
      {BuildContext? context,
      NotificationDataModel? notificationResponse,
      String? slugName,
      NetworkStatus? status}) {
    return AttendanceMethodState(
        status: status ?? this.status, slugName: slugName ?? this.slugName);
  }

  @override
  List<Object?> get props => [slugName, status];
}

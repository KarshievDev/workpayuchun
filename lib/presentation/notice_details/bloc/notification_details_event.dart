part of 'notification_details_bloc.dart';

abstract class NotificationDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotificationDetailsData extends NotificationDetailsEvent {
  final String? slugName;
  LoadNotificationDetailsData({this.slugName});
  @override
  List<Object?> get props => [slugName];
}

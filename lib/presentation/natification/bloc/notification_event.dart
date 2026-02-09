part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotificationData extends NotificationEvent {}

class RouteSlug extends NotificationEvent {
  final BuildContext context;
  final String? slugName;
  final NotificationDataModel? data;
  RouteSlug({this.slugName, required this.context, this.data});
  @override
  List<Object?> get props => [slugName, context, data];
}

class ClearNoticeButton extends NotificationEvent {}

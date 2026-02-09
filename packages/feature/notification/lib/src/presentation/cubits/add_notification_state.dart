import 'package:equatable/equatable.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';

class AddEditNotificationState extends Equatable {
  final NotificationDbEntity? notification;

  const AddEditNotificationState({this.notification});

  AddEditNotificationState copyWith({NotificationDbEntity? notification}) {
    return AddEditNotificationState(notification: notification ?? this.notification);
  }

  @override
  List<Object?> get props => [notification];
}

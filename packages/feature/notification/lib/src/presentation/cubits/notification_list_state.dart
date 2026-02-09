import 'package:core/core.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';

class NotificationListState {
  final List<NotificationDbEntity> readNotifications;
  final String dateFormat;
  final NetworkStatus status;
  final NotificationDataModel? notificationResponse;

  const NotificationListState(
      {this.dateFormat = 'M/dd/yyyy',
      this.readNotifications = const [],
      this.status = NetworkStatus.initial,
      this.notificationResponse});

  NotificationListState copyWith(
      {List<NotificationDbEntity>? readNotifications,
      String? dateFormat,
      NetworkStatus? status,
        NotificationDataModel? notificationResponse}) {
    return NotificationListState(
        readNotifications: readNotifications ?? this.readNotifications,
        dateFormat: dateFormat ?? this.dateFormat,
        status: status ?? this.status,
        notificationResponse: notificationResponse ?? this.notificationResponse);
  }
}

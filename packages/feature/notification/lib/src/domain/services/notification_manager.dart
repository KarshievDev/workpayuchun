import 'package:realm/realm.dart';
import '../../data/database_entities/notification_db_entity.dart';

abstract class NotificationManager {
  void cleanUp();

  Future<void> initializeNotification();

  RealmResults<NotificationDbEntity> getNotifications();

  void deleteNotification({required String notificationId});

  void updateNotification({required String notificationId, required bool seen});

  void createNotification(
      {required String title, required String description, required String payload, bool seen = false});

  Future<String?> getFcmToken();

  Future<String?> getApnsToken();
}

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification/notification.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:realm/realm.dart';
import 'notification_repository_database.dart';

class NotificationManagerImpl extends NotificationManager {
  final NotificationRepositoryDatabase notificationRepositoryDatabase;
  final FirebaseMessaging firebaseMessaging;

  NotificationManagerImpl({required this.notificationRepositoryDatabase, required this.firebaseMessaging});

  bool _initialized = false;

  @override
  void cleanUp() {
    if (!_initialized) {
      return;
    }
    notificationRepositoryDatabase.removeAllData();
    notificationRepositoryDatabase.close();
  }

  @override
  void createNotification(
      {required String title, required String description, required String payload, bool seen = false}) {
    notificationRepositoryDatabase.createNotification(title: title, description: description);
  }

  @override
  void deleteNotification({required String notificationId}) {
    notificationRepositoryDatabase.deleteNotification(notificationKey: notificationId);
  }

  @override
  Future<String?> getApnsToken() async {
    if (Platform.isIOS) {
      return await firebaseMessaging.getAPNSToken();
    }
    return null;
  }

  @override
  Future<String?> getFcmToken() {
    return firebaseMessaging.getToken();
  }

  @override
  RealmResults<NotificationDbEntity> getNotifications() {
    return notificationRepositoryDatabase.notificationQuery;
  }

  @override
  Future<void> initializeNotification() async {
    await notificationRepositoryDatabase.initialize();
    notificationRepositoryDatabase.purgeOldNotification(12);
    _initialized = true;
  }

  @override
  void updateNotification({required String notificationId, required bool seen}) {
    notificationRepositoryDatabase.updateNotification(notificationKey: notificationId, seen: seen);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:notification/src/data/services/local_notification_service.dart';
import 'package:notification/src/data/services/notification_database_factory.dart';
import 'package:notification/src/data/services/notification_manager_impl.dart';
import 'package:notification/src/data/services/notification_repository_database.dart';
import 'package:notification/src/domain/usecases/add_notification_usecase.dart';
import 'package:notification/src/domain/usecases/get_notification_token_usecase.dart';
import 'package:notification/src/domain/usecases/initialize_notification_usecase.dart';
import 'package:push/push.dart' as push;

class NotificationAppStartedHandlerService {
  final LocalNotificationService localNotificationService;
  final AddNotificationUseCase addNotificationUseCase;
  final GetNotificationTokenUseCase notificationTokenUseCase;
  final InitializeNotificationUseCase initializeNotificationUseCase;

  NotificationAppStartedHandlerService(
      {required this.localNotificationService,
      required this.addNotificationUseCase,
      required this.initializeNotificationUseCase,
      required this.notificationTokenUseCase}) {
    ///just printing token in log
    notificationTokenUseCase();
  }

  Future<void> onAppStarted() async {
    await initializeNotificationUseCase();

    if (Platform.isIOS) {
      initializeIosNotification();
    }
    if (Platform.isAndroid) {
      initializeFirebaseNotification();
    }
  }

  void initializeIosNotification() {
    baseInit();

    push.Push.instance.addOnMessage((message) {
      if (message.notification?.title != null || message.notification?.title != 'null') {
        ///adding notification message to save
        localNotificationService.showNotification(
            title: message.notification?.title ?? '', body: message.notification?.body ?? '', payload: '');
      }

      final encodedString = json.encode(message.data);
      localNotificationService.showNotification(
          title: message.notification?.title ?? '', body: message.notification?.body ?? '', payload: encodedString);
    });
  }

  void initializeFirebaseNotification() {
    baseInit();

    FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final payload = json.encode(message.data);
      if (message.notification != null) {
        if (message.notification?.title != null) {
          await Future.delayed(const Duration(seconds: 2));
          ///adding notification message to save
          addNotificationUseCase(
              title: message.notification?.title ?? '',
              description: message.notification?.body ?? '',
              payload: payload);
          if (message.notification?.android?.imageUrl != null) {
            await localNotificationService.showNotificationWithAttachment(
                title: message.notification?.title ?? '',
                body: message.notification?.body ?? '',
                payload: payload,
                image: message.notification?.android?.imageUrl);
          } else {
            await localNotificationService.showNotification(
                title: message.notification?.title ?? '', body: message.notification?.body ?? '', payload: payload);
          }
        }
      }
    });
  }

  void baseInit() {
    localNotificationService.didReceivedLocalNotificationSubject.listen((value) {
      onNotificationClick(value.payload);
    });

    localNotificationService.setOnNotificationClick(onNotificationClick);
  }

  onNotificationClick(payload) {
    if (payload != null) {
      debugPrint('Payload $payload');
    }
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final firebaseMessaging = FirebaseMessaging.instance;
  final databaseFactory = NotificationDatabaseFactory();
  final notificationRepositoryDatabase = NotificationRepositoryDatabase(databaseFactory: databaseFactory);
  final manager = NotificationManagerImpl(
      notificationRepositoryDatabase: notificationRepositoryDatabase, firebaseMessaging: firebaseMessaging);
  await manager.initializeNotification();
  final addNotificationUseCase = AddNotificationUseCase(notificationManager: manager);
  if (message.notification != null) {
    if (message.notification?.title != null || message.notification?.title != 'null') {
      addNotificationUseCase(
          title: message.notification!.title!, description: message.notification?.body ?? '', payload: '');
    }
  } else {}
}

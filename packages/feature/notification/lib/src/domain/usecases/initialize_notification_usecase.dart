import 'package:notification/notification.dart';

class InitializeNotificationUseCase {
  final NotificationManager notificationManager;

  InitializeNotificationUseCase({required this.notificationManager});

  Future<void> call() {
    return notificationManager.initializeNotification();
  }
}

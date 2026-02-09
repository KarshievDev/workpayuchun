import 'package:notification/notification.dart';

class AddNotificationUseCase {
  final NotificationManager notificationManager;

  AddNotificationUseCase({required this.notificationManager});

  void call({required String title, required String description, required String payload}) {
    return notificationManager.createNotification(title: title, description: description, payload: payload);
  }
}

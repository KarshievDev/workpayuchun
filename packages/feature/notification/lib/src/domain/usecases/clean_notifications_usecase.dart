import 'package:notification/notification.dart';

class CleanNotificationUseCase{
  final NotificationManager notificationManager;

  CleanNotificationUseCase({required this.notificationManager});

  void call(){
    return notificationManager.cleanUp();
  }
}




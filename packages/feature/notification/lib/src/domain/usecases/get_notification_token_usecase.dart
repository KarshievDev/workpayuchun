import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notification/notification.dart';

class GetNotificationTokenUseCase {
  final NotificationManager notificationManager;

  GetNotificationTokenUseCase({required this.notificationManager});

  Future<String?> call() async {
    try {
      if (Platform.isIOS) {
        final token = await notificationManager.getApnsToken();
        debugPrint('FirebaseToken : $token');
        return token;
      }
      final token = await notificationManager.getFcmToken();
      debugPrint('FirebaseToken : $token');
      return token;
    } catch (_) {
      return null;
    }
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';

class NotificationItem extends StatelessWidget {
  final NotificationDbEntity notification;
  final VoidCallback onTap;

  const NotificationItem({super.key, required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      tileColor: notification.seen ? null : Branding.colors.primaryLight.withAlpha(10),
      leading: notification.seen ? null : CircleAvatar(radius: 4.0, backgroundColor: Branding.colors.iconAccent),
      horizontalTitleGap: 0.0,
      title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
      subtitle: Text(notification.description),
      trailing: Text(getDateddMMMyyyyString(dateTime: notification.created)),
    );
  }
}

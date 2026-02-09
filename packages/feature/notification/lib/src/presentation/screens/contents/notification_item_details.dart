import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:notification/src/presentation/cubits/add_notification_cubit.dart';

class NotificationItemDetails extends StatelessWidget {
  final NotificationDbEntity notification;
  final String dateFormat;

  const NotificationItemDetails({super.key, required this.notification, required this.dateFormat});

  @override
  Widget build(BuildContext context) {

    context.read<AddEditNotificationCubit>().onNotificationUpdated(notification: notification);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Notification Center')),
        iconTheme: IconThemeData(color: Branding.colors.textInversePrimary),
        backgroundColor: Branding.colors.primaryLight,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notification.created.getFormattedDate(),
                  ),
                  const Divider(),
                  Text(notification.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notification/src/presentation/cubits/add_notification_cubit.dart';
import 'package:notification/src/presentation/cubits/notification_list_cubit.dart';
import 'contents/notification_main_content.dart';

typedef NotificationsScreenFactory = NotificationCenterScreen Function();

class NotificationCenterScreen extends StatelessWidget {
  final NotificationListCubitFactory notificationCubitFactory;
  final AddEditNotificationCubitFactory addEditNotificationCubitFactory;

  const NotificationCenterScreen(
      {super.key, required this.notificationCubitFactory, required this.addEditNotificationCubitFactory});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => notificationCubitFactory()),
        BlocProvider(create: (_) => addEditNotificationCubitFactory()),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              tr("notifications"),
              style: TextStyle(fontSize: 16.r),
            ),

          ),
          body: const NotificationMainContent()),
    );
  }
}

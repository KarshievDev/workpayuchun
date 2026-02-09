import 'package:bloc/bloc.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:notification/src/domain/services/notification_manager.dart';
import 'add_notification_state.dart';

typedef AddEditNotificationCubitFactory = AddEditNotificationCubit Function();

class AddEditNotificationCubit extends Cubit<AddEditNotificationState> {
  final NotificationManager notificationManager;

  AddEditNotificationCubit({required this.notificationManager}) : super(const AddEditNotificationState());

  void onNotificationUpdated({required NotificationDbEntity notification}) {
    notificationManager.updateNotification(notificationId: notification.key, seen: true);
  }

  void onNotificationAdded({required NotificationDbEntity notification}) {
    notificationManager.createNotification(
        title: notification.title, description: notification.description, payload: '');
  }
}

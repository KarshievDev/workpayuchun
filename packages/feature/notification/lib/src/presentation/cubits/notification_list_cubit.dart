import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:notification/notification.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:notification/src/domain/usecases/add_notification_usecase.dart';
import 'package:realm/realm.dart';
import 'notification_list_state.dart';

typedef NotificationListCubitFactory = NotificationListCubit Function();

class NotificationListCubit extends Cubit<NotificationListState> {
  final NotificationManager notificationManager;
  final NotificationFromServerUseCase notificationFromServerUseCase;
  final AddNotificationUseCase addNotificationUseCase;

  late StreamSubscription<RealmResultsChanges<NotificationDbEntity>> _querySubscription;
  late final RealmResults<NotificationDbEntity> _notificationQuery;

  NotificationListCubit(
      {required this.notificationManager,
      required this.notificationFromServerUseCase,
      required this.addNotificationUseCase})
      : super(const NotificationListState()) {
    _notificationQuery = notificationManager.getNotifications();
    _querySubscription = _notificationQuery.changes.listen(_onNotificationsCollectionChanged);
    onLoadNotificationServerData();
  }

  void onLoadNotificationServerData() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final notificationResponse = await notificationFromServerUseCase();
    notificationResponse.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      final notifications = r?.data?.notifications ?? [];
      if (_notificationQuery.isEmpty) {
        for (var notification in notifications) {
          if (notification.title != null) {
            addNotificationUseCase(title: notification.title!, description: notification.body ?? '', payload: '');
          }
        }
      }

      emit(state.copyWith(notificationResponse: r, status: NetworkStatus.success));
    });
  }

  void _onNotificationsCollectionChanged(RealmResultsChanges<NotificationDbEntity> event) async {
    const defaultDateFormat = 'M/dd/yyyy';
    emit(state.copyWith(
        readNotifications: _notificationQuery.toList().reversed.toList(), dateFormat: defaultDateFormat));
  }

  void delete(String notificationKey) {
    notificationManager.deleteNotification(notificationId: notificationKey);
  }

  @override
  Future<void> close() {
    _querySubscription.cancel();
    return super.close();
  }
}

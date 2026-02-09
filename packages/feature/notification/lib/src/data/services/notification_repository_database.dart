import 'package:core/core.dart';
import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:notification/src/data/services/notification_database_factory.dart';
import 'package:realm/realm.dart' as realm;

class NotificationRepositoryDatabase {
  final NotificationDatabaseFactory databaseFactory;

  NotificationRepositoryDatabase({required this.databaseFactory});

  late realm.Realm? _realmDb;
  late realm.RealmResults<NotificationDbEntity> _notificationQuery;

  realm.Realm? get realDB => _realmDb;

  realm.RealmResults<NotificationDbEntity> get notificationQuery => _notificationQuery;

  Future<void> initialize() async {
    _realmDb = await databaseFactory.generateDatabase();
    _setupQueries();
  }

  void _setupQueries() {
    _notificationQuery = _realmDb!.all<NotificationDbEntity>();
  }

  void purgeOldNotification(int monthCount) {
    final cutOff = DateTime.now().subtract(Duration(days: monthCount * 30));
    final oldNotifications = _realmDb?.query<NotificationDbEntity>(r'created < $0', [cutOff]);
    if (oldNotifications != null && oldNotifications.isNotEmpty) {
      _realmDb?.write(() {
        _realmDb?.deleteMany<NotificationDbEntity>(oldNotifications);
      });
    }
  }

  ///Clean-up the database
  void clean() {
    removeAllData();
  }

  void close() {
    _realmDb?.close();
    _realmDb = null;
  }

  void createNotification({required String title, required String description, bool seen = false}) {
    final notification = NotificationDbEntity(generateNewUUID(), title, description, currentDate(), seen);
    _realmDb?.write(() {
      _realmDb?.add<NotificationDbEntity>(notification);
    });
  }

  void updateNotification({required String notificationKey, required bool seen}) {
    final updateResult = _realmDb?.query<NotificationDbEntity>(r'key = $0', [notificationKey]);
    if (updateResult != null && updateResult.isNotEmpty) {
      final updatedData = updateResult.first;
      final updatedNotification =
          NotificationDbEntity(updatedData.key, updatedData.title, updatedData.description, updatedData.created, seen);
      _realmDb!.write(() {
        _realmDb!.add<NotificationDbEntity>(updatedNotification, update: true);
      });
    }
  }

  void removeAllData() {
    _realmDb?.write(() {
      _realmDb?.deleteAll<NotificationDbEntity>();
    });
  }
  
  void deleteNotification({required String notificationKey}){
    final notificationToDelete = _realmDb?.query<NotificationDbEntity>(r'key = $0',[notificationKey]);
    if(notificationToDelete != null && notificationToDelete.isNotEmpty){
      _realmDb!.write((){
        _realmDb!.delete<NotificationDbEntity>(notificationToDelete.first);
      });
    }
  }
}

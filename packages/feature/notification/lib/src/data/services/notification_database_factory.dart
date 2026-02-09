import 'package:notification/src/data/database_entities/notification_db_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart' as realm;

class NotificationDatabaseFactory {
  Future<realm.Realm> generateDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/hrm_notification.realm';
    final config = realm.Configuration.local([NotificationDbEntity.schema], schemaVersion: 1, path: path);
    return realm.Realm(config);
  }
}

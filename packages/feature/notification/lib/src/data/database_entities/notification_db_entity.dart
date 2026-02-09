import 'package:realm/realm.dart';

part 'notification_db_entity.realm.dart';

@RealmModel()
class _NotificationDbEntity {
  @PrimaryKey()
  late String key;
  late String title;
  late String description;
  late DateTime created;
  late bool seen;
}

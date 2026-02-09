import 'package:hrm_framework/src/domain/services/storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelperImpl extends StorageHelper {
  final SharedPreferences pref;

  StorageHelperImpl({required this.pref});

  @override
  Future<void> delete({required String key}) async {
    await pref.remove(key);
  }

  @override
  Future<String?> read({required String key}) async {
    return pref.getString(key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await pref.setString(key, value);
  }
}

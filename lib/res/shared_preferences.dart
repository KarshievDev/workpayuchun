import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedUtil {

  static setValue(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value ?? '');
  }

  static setRemoteModeType(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyRemoteModeType, value);
  }

  static Future<int?> getRemoteModeType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getInt(keyRemoteModeType);
      return value ?? 0;
    } catch (error) {
      return 0;
    }
  }

  static setLanguageIntValue(String key, int? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value!);
  }

  static Future<int?> getSelectLanguage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getInt(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static Future<String?> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getString(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static setIntValue(String key, int? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value!);
  }

  static setBoolValue(String key, bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value!);
  }

  static Future<int?> getIntValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getInt(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getBool(key);
      return value ?? false;
    } catch (error) {
      return false;
    }
  }

  static deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static storeLocalData({required String? key, required String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, value!);
  }

  static Future<String?> getLocalData({@required String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }
}

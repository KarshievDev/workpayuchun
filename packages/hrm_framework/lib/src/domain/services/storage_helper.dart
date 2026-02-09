import 'dart:async';

abstract class StorageHelper {
  Future<void> write({required String key, required String value});

  Future<String?> read({required String key});

  Future<void> delete({required String key});
}

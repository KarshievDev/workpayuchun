import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:offline_location/domain/offline_location_repository.dart';

String location = 'location';

class OfflineLocationRepositoryImpl implements OfflineLocationRepository {
  final HiveInterface hive;

  OfflineLocationRepositoryImpl({required this.hive}) {
    hive.registerAdapter(LocationModelAdapter());
  }

  Future<Box<LocationModel>> _openBox() async {
    try {
      final box = await hive.openBox<LocationModel>(location);
      return box;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> add(LocationModel location) async {
    final box = await _openBox();
    await box.add(location);
  }

  @override
  Future<void> deleteAllLocation() async {
    final box = await _openBox();
    await box.clear();
    debugPrint("Delete all Local data ${box.values}");
  }

  @override
  Future<LocationModel?> getUserFirstPosition() async {
    final box = await _openBox();
    return box.isNotEmpty ? box.values.first : null;
  }

  @override
  Future<LocationModel?> getUserLastPosition() async {
    final box = await _openBox();
    return box.isNotEmpty ? box.values.last : null;
  }

  @override
  Future<List<Map<String, dynamic>>> toMapList() async {
    final box = await _openBox();
    return box.values.map((e) => e.toJson()).toList();
  }
}

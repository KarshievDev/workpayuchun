import 'package:core/core.dart';

abstract class OfflineLocationRepository{
  Future<void> add(LocationModel location);
  Future<LocationModel?> getUserLastPosition();
  Future<LocationModel?> getUserFirstPosition();
  Future<void> deleteAllLocation();
  Future<List<Map<String, dynamic>>> toMapList();
}
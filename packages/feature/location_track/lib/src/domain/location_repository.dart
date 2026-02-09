import 'package:core/core.dart';
import 'package:geolocator/geolocator.dart';

abstract class ILocationRepository {
  Future<void> sendLocationToFirebase(String uid, LocationModel location);
  Future<void> storeLocationLocally(LocationModel location);
  Future<List<Map<String,dynamic>>> fetchStoredLocations();
  Future<void> clearStoredLocations();
  void getCurrentLocationStream({required String uid});
  void dispose();
  Future<Position?> getUserPositionFuture();
  Future<String?> onLocationRefresh();
  Stream<String> get placeStream;
}









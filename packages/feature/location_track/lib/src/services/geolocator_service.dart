import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class GeoLocatorService {
  ///get current position as stream
  Stream<Position> getCoordinates() {
    LocationSettings settings = const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5);

    return Geolocator.getPositionStream(locationSettings: settings);
  }

  ///get current position future
  Future<Position?> getCordFuture() {
    return Geolocator.getLastKnownPosition();
  }

  ///last cached position
  Future<Position?> getLastKnownPosition() {
    return Geolocator.getLastKnownPosition();
  }

  ///get address by position
  Future<List<geocoding.Placemark>?> getAddress(Position position) async {
    return await geocoding.GeocodingPlatform.instance?.placemarkFromCoordinates(position.latitude, position.longitude);
  }
}

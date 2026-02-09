import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location_track/src/domain/geo_service.dart';

class GeoLocatorServiceImpl extends IGeoService {
  ///get current position as stream
  @override
  Stream<Position> getCoordinates() {
    const settings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5);
    return Geolocator.getPositionStream(locationSettings: settings);
  }

  ///get current position future
  @override
  Future<Position?> getCoordinateFuture() {
    return Geolocator.getCurrentPosition();
  }

  ///last cached position
  @override
  Future<Position?> getLastKnownPosition() {
    return Geolocator.getLastKnownPosition();
  }

  ///get address by position
  @override
  Future<List<geocoding.Placemark>?> getAddress(Position position) async {
    return await geocoding.GeocodingPlatform.instance?.placemarkFromCoordinates(position.latitude, position.longitude);
  }
}

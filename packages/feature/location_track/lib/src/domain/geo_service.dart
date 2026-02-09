import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

abstract class IGeoService {
  Stream<Position> getCoordinates();
  Future<Position?> getCoordinateFuture();
  Future<Position?> getLastKnownPosition();
  Future<List<geocoding.Placemark>?> getAddress(Position position);
}









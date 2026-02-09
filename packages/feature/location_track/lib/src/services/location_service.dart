import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'dart:io' as platform;

class LocationService {
  final location = Location();

  /// StreamController to broadcast location updates
  final StreamController<LocationData> _locationController = StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationController.stream;

  /// Initialize Location Service
  Future<void> initializeLocation() async {
    try {
      /// Check if location services are enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          if (kDebugMode) {
            print("Location services are disabled.");
          }
          return;
        }
      }

      // Check and request permissions
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (kDebugMode) {
            print("Location permissions are denied.");
          }
          return;
        }
      }

      // Configure Android-specific settings
      if (platform.Platform.isAndroid) {
        await location.changeSettings(interval: 10000, distanceFilter: 10);
      }

      // Enable background mode (if supported)
      if (await location.isBackgroundModeEnabled()) {
        await location.enableBackgroundMode(enable: true);
      }

      // Start listening to location changes
      location.onLocationChanged.listen((locationData) {
        _locationController.add(locationData);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing location: $e");
      }
    }
  }

  /// Get the current location once
  Future<LocationData?> getLocation() async {
    try {
      return await location.getLocation();
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
      return null;
    }
  }

  /// Check if permissions are granted
  Future<PermissionStatus> hasPermission() async {
    try {
      return await location.hasPermission();
    } catch (e) {
      if (kDebugMode) {
        print("Error checking permission: $e");
      }
      return PermissionStatus.denied;
    }
  }

  /// Dispose StreamController to prevent memory leaks
  void dispose() {
    _locationController.close();
  }
}

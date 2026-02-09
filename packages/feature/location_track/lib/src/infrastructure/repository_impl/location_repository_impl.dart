import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:location_track/location_track.dart';
import 'package:location_track/src/domain/location_repository.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:offline_location/domain/offline_location_repository.dart';

class LocationRepositoryImpl implements ILocationRepository {
  final FirebaseLocationStoreProvider firebase;
  final OfflineLocationRepository local;
  final LocationService locationService;
  final GeoLocatorService geoLocationService;
  final MetaClubApiClient metaClubApiClient;

  LocationRepositoryImpl({
    required this.firebase,
    required this.local,
    required this.locationService,
    required this.geoLocationService,
    required this.metaClubApiClient,
  }){
    locationService.initializeLocation();
  }

  @override
  Future<void> sendLocationToFirebase(String uid, LocationModel location) async {
    await firebase.sendLocationToFirebase(uid, location.toJson());
  }

  @override
  Future<void> storeLocationLocally(LocationModel location) async {
    await local.add(location);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchStoredLocations() async {
    return await local.toMapList();
  }

  @override
  Future<void> clearStoredLocations() async {
    await local.deleteAllLocation();
  }

  final _placeController = StreamController<String>.broadcast();

  @override
  Stream<String> get placeStream => _placeController.stream;

  LocationData userLocation = LocationData.fromMap({});
  geocoding.Placemark? placeMark;
  String place = '';
  late StreamSubscription locationSubscription;
  LatLong initialCameraPosition = const LatLong(23.256555, 90.157965);

  ///return driver current location stream
  ///for this we use another package called {Location:any}
  ///to get location more better way
  @override
  void getCurrentLocationStream({required String uid}) async {
    ///location permission check
    final isGranted = await askForLocationAlwaysPermission();

    if (!isGranted) {
      await askForLocationAlwaysPermission();
    }

    ///listening data from location service
    locationSubscription = locationService.locationStream.listen((event) async {
      ///initialize userLocation data
      userLocation = event;

      ///convert locationData into Position data
      final position = Position(
        latitude: event.latitude!,
        longitude: event.longitude!,
        speed: event.speed!,
        heading: event.heading!,
        altitude: event.altitude!,
        accuracy: event.accuracy!,
        timestamp: DateTime.now(),
        speedAccuracy: event.speedAccuracy!,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );

      final places = await getAddressByPosition(position: position);
      placeMark = places?.first;
      place =
          '${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}';
      if (!_placeController.isClosed) {
        _placeController.add(place);
      }

      ///when locationSubscription is enable only then
      ///location data can be processed to manipulate
      if (!locationSubscription.isPaused) {
        ///Inactive all listener to listen location data for a while
        locationSubscription.pause();
        debugPrint('isPaused ${locationSubscription.isPaused}');
      }

      ///initial camera position
      initialCameraPosition = LatLong(event.latitude!, event.longitude!);
    });

    ///when locationSubscription is enable only then
    ///location data can be processed to manipulate
    if (!locationSubscription.isPaused) {
      final position = await getUserPositionFuture();
      userLocation = LocationData.fromMap({"latitude": position?.latitude, "longitude": position?.longitude});
      if (position != null) {
        ///getting address from current position
        _addLocationDataToLocal(position: position, uid: uid);
      }

      ///store data to server from hive
      _deleteLocationDataAndStoreToServer();

      debugPrint('isPaused ${locationSubscription.isPaused}');
    }

    ///set timer to toggle location subscription
    Timer.periodic(const Duration(minutes: 2), (timer) async {
      if (locationSubscription.isPaused) {
        locationSubscription.resume();
      }
      debugPrint('isPaused ${locationSubscription.isPaused}');
    });
  }

  /// Tries to ask for "location always" permissions from the user.
  /// Returns `true` if successful, `false` otherwise.
  Future<bool> askForLocationAlwaysPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return false;
    }
    return true;
  }

  void _disposePlaceController() async {
    await _placeController.close();
  }

  Future<List<geocoding.Placemark>?> getAddressByPosition({required Position position}) async {
    return await geoLocationService.getAddress(position);
  }

  ///return future location
  @override
  Future<Position?> getUserPositionFuture() async {
    try {
      return await geoLocationService.getCordFuture();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> onLocationRefresh() async {
    Position? position = await getUserPositionFuture();
    try {
      if (position != null) {
        final places = await getAddressByPosition(position: position);
        placeMark = places?.first;
        place =
            '${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}';
      }
      return place;
    } catch (e) {
      rethrow;
    }
  }


  ///store data to local
  _addLocationDataToLocal({required Position position, required String uid}) async {
    userLocation = LocationData.fromMap({"latitude": position.latitude, "longitude": position.longitude});

    final places = await getAddressByPosition(position: position);

    placeMark = places?.first;

    place =
        '${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}';
    if (!_placeController.isClosed) {
      _placeController.add(place);
    }

    Timer.periodic(const Duration(minutes: 2), (timer) async {
      if (kDebugMode) {
        print('local from position ${position.toString()}');
      }

      double distance = 0.0;

      final locationModel = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        speed: position.speed,
        city: placeMark?.locality,
        country: placeMark?.country,
        countryCode: placeMark?.isoCountryCode,
        address:
            '${placeMark?.name} ${placeMark?.subLocality} ${placeMark?.thoroughfare} ${placeMark?.subThoroughfare}',
        heading: position.heading,
        distance: distance,
        datetime: DateTime.now().toString(),
      );

      ///add data to local database
      storeLocationLocally(locationModel);

      sendLocationToFirebase(uid, locationModel);
    });
  }

  ///data will be delete after data store to server
  _deleteLocationDataAndStoreToServer() async {
    ///data will be stored to server after 4 minute
    Timer.periodic(const Duration(minutes: 10), (timer) async {
      final data = await local.toMapList();
      if (data.length > 3 && !locationSubscription.isPaused) {
        if (kDebugMode) {
          print('data that u have to sent server $data');
        }
        metaClubApiClient.storeLocationToServer(locations: data, date: DateTime.now().toString()).then((
          isStored,
        ) async {
          isStored.fold((l) {}, (r) async {
            if (r) {
              await local.deleteAllLocation();
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _disposePlaceController();
  }
}

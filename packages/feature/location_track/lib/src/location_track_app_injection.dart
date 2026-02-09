import 'package:core/core.dart';
import 'package:location_track/location_track.dart';
import 'domain/location_repository.dart';
import 'infrastructure/repository_impl/location_repository_impl.dart';

class LocationTrackInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<LocationService>(LocationService());
    instance.registerSingleton<GeoLocatorService>(GeoLocatorService());
    instance.registerSingleton<FirebaseLocationStoreProvider>(FirebaseLocationStoreProvider());
    instance.registerLazySingleton<ILocationRepository>(
      () => LocationRepositoryImpl(
        firebase: instance(),
        local: instance(),
        locationService: instance(),
        geoLocationService: instance(),
        metaClubApiClient: instance(),
      ),
    );
    instance.registerLazySingleton(() => LocationRefreshUseCase(iLocationRepository: instance()));
    instance.registerLazySingleton(() => StreamPlaceUseCase(repository: instance()));
    instance.registerLazySingleton(() => StreamLocationUseCase(repo: instance()));
    instance.registerLazySingleton(() => CurrentLocationUseCase(repo: instance()));
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:location_track/src/domain/location_repository.dart';

class CurrentLocationUseCase {
  final ILocationRepository repo;

  CurrentLocationUseCase({required this.repo});

  Future<Position?> call() async {
    return await repo.getUserPositionFuture();
  }
}

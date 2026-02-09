import 'package:location_track/src/domain/location_repository.dart';

class LocationRefreshUseCase {
  ILocationRepository iLocationRepository;

  LocationRefreshUseCase({required this.iLocationRepository});

  Future<String?> call() async {
    return iLocationRepository.onLocationRefresh();
  }
}

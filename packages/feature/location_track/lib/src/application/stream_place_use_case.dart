import 'package:location_track/src/domain/location_repository.dart';

class StreamPlaceUseCase {
  final ILocationRepository repository;

  StreamPlaceUseCase({required this.repository});

  Stream<String> call() {
    return repository.placeStream;
  }
}

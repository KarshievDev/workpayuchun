import 'package:location_track/src/domain/location_repository.dart';

class StreamLocationUseCase {
  final ILocationRepository repo;

  StreamLocationUseCase({required this.repo});

  void call({required String uid}) {
    repo.getCurrentLocationStream(uid: uid);
  }
}

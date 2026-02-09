import 'package:core/core.dart';
import 'data/offline_location_repository_impl.dart';
import 'domain/offline_location_repository.dart';

class OfflineLocationInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<OfflineLocationRepository>(OfflineLocationRepositoryImpl(hive: instance()));
  }
}

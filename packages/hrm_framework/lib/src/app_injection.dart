import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:hrm_framework/src/data/services/connectivity_status_provider_impl.dart';
import 'package:hrm_framework/src/services/connectivity_status_provider.dart';

class FrameworkAppInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<ConnectivityStatusProvider>(ConnectivityStatusProviderImpl(connectivity: Connectivity()));
  }
}

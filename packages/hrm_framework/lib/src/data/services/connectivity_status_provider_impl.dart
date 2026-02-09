import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hrm_framework/src/services/connectivity_status_provider.dart';

class ConnectivityStatusProviderImpl implements ConnectivityStatusProvider {
  final Connectivity connectivity;

  final List<ConnectivityChangedHandler> _handlers = [];

  ConnectivityStatusProviderImpl({required this.connectivity}) {
    connectivity.onConnectivityChanged.listen((status) {
      for (final handler in _handlers) {
        handler.call(status != [ConnectivityResult.none]);
      }
    });
  }

  @override
  Future<bool> get isConnected async {
    var connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != [ConnectivityResult.none];
  }

  @override
  void addConnectivityChangedHandler(ConnectivityChangedHandler handler) {
    _handlers.add(handler);
  }
}

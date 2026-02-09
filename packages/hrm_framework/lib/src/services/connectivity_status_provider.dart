typedef ConnectivityChangedHandler = void Function(bool isConnected);

abstract class ConnectivityStatusProvider {
  Future<bool> get isConnected;
  void addConnectivityChangedHandler(ConnectivityChangedHandler handler);
}

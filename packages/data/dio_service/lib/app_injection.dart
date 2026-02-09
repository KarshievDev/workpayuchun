import 'package:core/core.dart';
import 'dio_service.dart';

class HTTPServiceInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<HttpService>(HttpServiceImpl());
  }
}
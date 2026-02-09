import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio? dio;
  final Connectivity? connectivity;

  DioConnectivityRequestRetrier(
      {required this.dio, required this.connectivity});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResults) {
      streamSubscription!.cancel();
      if (!connectivityResults.contains(ConnectivityResult.none)) {
        responseCompleter.complete(dio?.request(requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                contentType: requestOptions.contentType)));
      }
    });
    return responseCompleter.future;
  }
}

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  Connectivity connectivity = Connectivity();
  InternetBloc() : super(const InternetState()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(state.copyWith(message: "Connected",status: InternetStatus.online));
      } else if (event is NotConnectedEvent) {
        emit(state.copyWith(message: "Not Connected",status: InternetStatus.offline));
      }
    });
    checkConnectionStatus();
  }

  void checkConnectionStatus() async {
    connectivity.checkConnectivity().then((res){
      checkStatus(res);
      _subscription = Connectivity().onConnectivityChanged.listen(checkStatus);
    });
  }

  void checkStatus(List<ConnectivityResult> result) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty) {
        add(NotConnectedEvent());
      } else {
        add(ConnectedEvent());
      }
    } on SocketException catch (_) {
      add(NotConnectedEvent());
    }
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
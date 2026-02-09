import 'package:bloc/bloc.dart';
import 'dart:developer';
class AppBlocStateObserver extends BlocObserver{

  @override
  onChange(BlocBase bloc,Change change){
    super.onChange(bloc, change);
    log('onChange ${bloc.runtimeType}, $change');
  }
  @override
  onError(BlocBase bloc,Object error,StackTrace stackTrace){
    super.onError(bloc, error, stackTrace);
    log('onError ${bloc.runtimeType}, $error, $stackTrace');
  }
}


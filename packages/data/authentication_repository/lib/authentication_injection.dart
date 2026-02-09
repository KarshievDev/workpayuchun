import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';

class AuthenticationInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<AuthenticationRepository>(AuthenticationRepository(hrmCoreBaseService: instance()));
  }
}
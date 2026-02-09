import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:user_repository/user_repository.dart';

class LoginWithEmailPasswordUseCase {
  final AuthenticationRepository authenticationRepository;

  LoginWithEmailPasswordUseCase({required this.authenticationRepository});

  Future<Either<Failure, LoginData?>> call({required String email, required String password, String? deviceId, String? deviceInfo}) async {
    final callBack = await authenticationRepository.login(email: email, password: password, deviceId: deviceId, deviceInfo: deviceInfo);
    return callBack;
  }
}

import 'package:authentication_repository/authentication_repository.dart';

class LogoutUseCase{
  final AuthenticationRepository authenticationRepository;

  LogoutUseCase({required this.authenticationRepository});

  Future<void> call() async {
    return await authenticationRepository.logout();
  }
}
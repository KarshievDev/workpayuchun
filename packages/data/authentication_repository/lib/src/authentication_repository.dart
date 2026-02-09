import 'dart:async';
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final HRMCoreBaseService hrmCoreBaseService;
  AuthenticationStatus initialStatus = AuthenticationStatus.unauthenticated;

  AuthenticationRepository({required this.hrmCoreBaseService});

  final _controller = StreamController<AuthenticationStatus>();
  final _userController = StreamController<LoginData>();

  void updateAuthenticationStatus(AuthenticationStatus status) {
    initialStatus = status;
  }

  void updateUserData(LoginData data) {
    _userController.add(data);
  }

  void clearUserData(LoginData data) {
    _userController.add(data);
  }

  Stream<AuthenticationStatus> get status async* {
    yield initialStatus;
    yield* _controller.stream;
  }

  Stream<LoginData> get loginData async* {
    yield* _userController.stream;
  }

  Future<Either<Failure, LoginData?>> login({
    required String email,
    required String password,
    String? deviceId,
    String? deviceInfo,
  }) async {
    final userEither = await hrmCoreBaseService.login(
      email: email,
      password: password,
      deviceId: deviceId,
      deviceInfo: deviceInfo,
    );
    userEither.fold(
      (l) {
        _controller.add(AuthenticationStatus.unauthenticated);
      },
      (r) {
        _controller.add(AuthenticationStatus.authenticated);
        _userController.add(r!);
      },
    );
    return userEither;
  }

  Future<void> logout() async {
    hrmCoreBaseService.logout();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

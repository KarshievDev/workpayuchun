import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;
  late StreamSubscription<LoginData> _loginDataSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
       super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequest);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
    _loginDataSubscription = _authenticationRepository.loginData.listen(
      (userData) => add(AuthenticationUserChanged(userData)),
    );
  }

  _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    debugPrint('event.data.toJson()${event.data.toJson()}');
    globalState.set(authToken, event.data.user?.token);
    if (event.data.user != null) {
      return emit(AuthenticationState.authenticated(event.data));
    }
    return emit(const AuthenticationState.unauthenticated());
  }

  _onAuthenticationLogoutRequest(
    AuthenticationLogoutRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.logout();
    emit(const AuthenticationState.unauthenticated());
  }

  Future<void> onClose() async {
    _authenticationStatusSubscription.cancel();
    _loginDataSubscription.cancel();
    _authenticationRepository.dispose();
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final userJson = json['user'];

    if (status == AuthenticationStatus.authenticated.name && userJson != null) {
      final user = LoginData.fromJson(userJson);
      if (user.user != null) {
        globalState.set(authToken, user.user!.token);
      }
      _authenticationRepository.updateAuthenticationStatus(
        AuthenticationStatus.authenticated,
      );
      _authenticationRepository.updateUserData(user);
      return AuthenticationState.authenticated(user);
    }
    return const AuthenticationState.unauthenticated();
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    return <String, dynamic>{
      'status': state.status.name,
      'user': state.data?.toJson(),
    };
  }
}

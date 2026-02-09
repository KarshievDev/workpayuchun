part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable{

  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent{

  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class AuthenticationUserChanged extends AuthenticationEvent{

  final LoginData data;

  const AuthenticationUserChanged(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthenticationLogoutRequest extends AuthenticationEvent{}


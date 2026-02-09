part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable{

  final AuthenticationStatus status;
  final LoginData? data;

  const AuthenticationState._({this.status = AuthenticationStatus.unknown,this.data});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(LoginData data) : this._(status: AuthenticationStatus.authenticated,data: data);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status];
}

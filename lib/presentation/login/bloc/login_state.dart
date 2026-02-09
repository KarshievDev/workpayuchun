part of 'login_bloc.dart';

enum LoginAction{obscure, login, unknown}

class LoginState extends Equatable {
  final bool isValid;
  final bool isObscure;
  final Failure? failure;
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final LoginData? user;
  final LoginAction loginAction;

  const LoginState({this.isValid = false,
    this.isObscure = true,
      this.status = FormzSubmissionStatus.initial,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.loginAction =  LoginAction.unknown,
      this.failure,
      this.user});

  LoginState copyWith(
      { FormzSubmissionStatus? status,bool? isValid, bool? isObscure, Email? email, Password? password, LoginData? user,Failure? failure, LoginAction? loginAction}) {
    return LoginState(
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        isObscure: isObscure ?? this.isObscure,
        email: email ?? this.email,
        password: password ?? this.password,
        failure: failure ?? this.failure,
        loginAction: loginAction ?? this.loginAction,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, email, password,user,failure,isObscure,loginAction];
}

part of 'password_change_bloc.dart';

abstract class PasswordChangeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordChange extends PasswordChangeEvent {
  final PasswordChangeBody passwordChangeBody;
  final BuildContext context;

  PasswordChange(this.passwordChangeBody, this.context);
  @override
  List<Object> get props => [passwordChangeBody];
}

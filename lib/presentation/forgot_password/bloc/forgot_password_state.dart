part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final NetworkStatus status;

  const ForgotPasswordState({
    required this.status,
  });

  ForgotPasswordState copyWith({
    NetworkStatus? status,
  }) {
    return ForgotPasswordState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}

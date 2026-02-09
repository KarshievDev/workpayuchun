part of 'password_change_bloc.dart';

class PasswordChangeState extends Equatable {
  final NetworkStatus status;

  const PasswordChangeState({
    required this.status,
  });

  PasswordChangeState copyWith({
    NetworkStatus? status,
  }) {
    return PasswordChangeState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}

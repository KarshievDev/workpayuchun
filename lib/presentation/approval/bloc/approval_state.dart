part of 'approval_bloc.dart';

class ApprovalState extends Equatable {
  final NetworkStatus status;
  final ApprovalModel? approval;

  const ApprovalState(
      {required this.status, this.approval});

  ApprovalState copyWith(
      {NetworkStatus? status, ApprovalModel? approval}) {
    return ApprovalState(
        status: status ?? this.status,
        approval: approval ?? this.approval);
  }

  @override
  List<Object?> get props => [status, approval];
}

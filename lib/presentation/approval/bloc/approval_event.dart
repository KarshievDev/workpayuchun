part of 'approval_bloc.dart';

abstract class ApprovalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApprovalInitialDataRequest extends ApprovalEvent {
  ApprovalInitialDataRequest();

  @override
  List<Object?> get props => [];
}

class ApproveOrRejectAction extends ApprovalEvent {
  final String approvalId;
  final int type;
  final BuildContext context;

  ApproveOrRejectAction({required this.approvalId,required this.type,required this.context});

  @override
  List<Object?> get props => [approvalId, type, context];
}

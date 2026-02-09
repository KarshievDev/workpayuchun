import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'approval_event.dart';
part 'approval_state.dart';

class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState> {
  final MetaClubApiClient metaClubApiClient;

  ApprovalBloc({required this.metaClubApiClient})
      : super(const ApprovalState(status: NetworkStatus.initial)) {
    on<ApprovalInitialDataRequest>(_onApprovalInitialDataRequest);
    on<ApproveOrRejectAction>(_onApproveOrRejectAction);
  }

  FutureOr<void> _onApprovalInitialDataRequest(ApprovalInitialDataRequest event, Emitter<ApprovalState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await metaClubApiClient.getApprovalData();
    data.fold((l) {
      emit(const ApprovalState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, approval: r));
    });
  }

  Future<ApprovalDetailsModel?> onApprovalDetails({required String approvalId, required String approvalUserId}) async {
    final data = await metaClubApiClient.getApprovalListDetails(approvalId: approvalId, approvalUserId: approvalUserId);
    return data.fold((l) => null, (r) => r);
  }

  bool isApproved(status) {
    switch (status) {
      case 'Active':
        return false;
      case 'Reject':
        return false;
      default:
        return true;
    }
  }
  FutureOr<void> _onApproveOrRejectAction(ApproveOrRejectAction event, Emitter<ApprovalState> emit)async {
    emit(state.copyWith(status: NetworkStatus.loading));
    await metaClubApiClient.approvalApprovedOrReject(approvalId: event.approvalId, type: event.type).then((value) {
      value.fold(
        (failure) {
          // Handle failure case if needed
        },
        (success) {
          if(success){
            add(ApprovalInitialDataRequest());
            if (event.context.mounted) {
              Navigator.of(event.context).pop();
            }
          }
        }
      );
    });
  }
}

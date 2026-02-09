import 'dart:ui';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_details_bloc/leave_details_state.dart';

typedef LeaveDetailsCubitFactory = LeaveDetailsCubit Function({required int userId, required int requestId});

class LeaveDetailsCubit extends Cubit<LeaveDetailsState> {
  final LoadLeaveDetailsDataUseCase loadLeaveDetailsDataUseCase;
  final LeaveCancelRequestUseCase leaveCancelRequestUseCase;
  final int userId;
  final int requestId;

  LeaveDetailsCubit(
      {required this.leaveCancelRequestUseCase,
      required this.loadLeaveDetailsDataUseCase,
      required this.userId,
      required this.requestId})
      : super(LeaveDetailsState()){
    loadLeaveDetails();
  }

  void loadLeaveDetails() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final leaveDetailsResponse = await loadLeaveDetailsDataUseCase(uid: userId, rid: requestId);
    leaveDetailsResponse.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(leaveDetailsModel: r, status: NetworkStatus.success));
    });
  }

  void cancelLeave({required VoidCallback onCancelled}) async {
    emit(state.copyWith(status: NetworkStatus.loading, isCancelled: true));
    final isCancelled = await leaveCancelRequestUseCase(rid: requestId);
    if (isCancelled) {
      emit(state.copyWith(status: NetworkStatus.success));
      onCancelled();
    } else {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }
}

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/deduction/bloc/deduction/deduction_state.dart';

typedef DeductionCubitFactory = DeductionCubit Function();

class DeductionCubit extends Cubit<DeductionState> {
  final LoadDeductionUseCase loadDeductionUseCase;
  final SubmitDeductionAppealUseCase submitDeductionAppealUseCase;

  DeductionCubit({required this.loadDeductionUseCase, required this.submitDeductionAppealUseCase})
      : super(const DeductionState()) {
    onLoadDeductionData();
  }

  void onLoadDeductionData() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await loadDeductionUseCase();
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(deductionData: r,status: NetworkStatus.success));
    });
  }

  Future<bool> submitAppeal(
      {required BuildContext context, TextEditingController? appealController, int? appealId}) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    BodyAppeal body = BodyAppeal(appealDetails: appealController?.text);
    final data = await submitDeductionAppealUseCase(body: body, deductionID: appealId);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success));
      appealController?.clear();
      onLoadDeductionData();
      Navigator.pop(context);
    });
    return true;
  }
}

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/verbal_wraning/verbal_warning_state.dart';

typedef VerbalWarningBlocFactory = VerbalWarningBloc Function();

class VerbalWarningBloc extends Cubit<VerbalWarningState> {
  final LoadComplainUseCase loadComplainUseCase;
  final SubmitComplainUseCase submitComplainUseCase;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  VerbalWarningBloc({required this.loadComplainUseCase, required this.submitComplainUseCase})
      : super(const VerbalWarningState()) {
    _loadVerbalWarningData();
  }

  void _loadVerbalWarningData() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await loadComplainUseCase(complain: false);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, failure: l));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, verbalWarningData: r));
    });
  }

  Future<bool> submitVerbalWarning({required BuildContext context}) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    ComplainBody body = ComplainBody(
        title: titleController.text,
        description: descriptionController.text,
        employeeId: state.employee?.id,
        date: state.date,
        attachment: state.document);
    final data = await submitComplainUseCase(body: body, complain: false);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, failure: l));
    }, (r) {
      emit(VerbalWarningState(status: NetworkStatus.success, verbalWarningData: state.verbalWarningData));
      titleController.clear();
      descriptionController.clear();
      _loadVerbalWarningData();
      Navigator.pop(context);
    });
    return true;
  }

  void onDateUpdated({required String date}) {
    emit(state.copyWith(date: date));
  }

  void onDeadlineUpdated({required String date}) {
    emit(state.copyWith(deadline: date));
  }

  void onEmployeeSelected({required PhoneBookUser employee}) {
    emit(state.copyWith(employee: employee));
  }

  void onDocumentUpdated({String? document}) {
    emit(state.copyWith(document: document));
  }

  void onAppeal({bool isAppeal = true}) {
    emit(state.copyWith(isAppeal: isAppeal, isAgree: !isAppeal));
  }

  void onExplanation({required bool isExplain}) {
    emit(state.copyWith(writeExplanation: isExplain));
  }

  void onDirectHR({required bool directHR}) {
    emit(state.copyWith(directTalkHR: directHR));
  }
}

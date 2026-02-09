import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_state.dart';

typedef ComplainBlocFactory = ComplainBloc Function();

class ComplainBloc extends Cubit<ComplainState> {
  final LoadComplainUseCase loadComplainUseCase;
  final SubmitComplainUseCase submitComplainUseCase;
  final LoadComplainRepliesUseCase loadComplainRepliesUseCase;
  final SubmitComplainReplyUseCase submitComplainReplyUseCase;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final explanationController = TextEditingController();

  ComplainBloc(
      {required this.loadComplainUseCase,
      required this.submitComplainUseCase,
      required this.loadComplainRepliesUseCase,
      required this.submitComplainReplyUseCase})
      : super(const ComplainState()) {
    _loadComplainData();
  }

  void _loadComplainData() async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await loadComplainUseCase();
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, failure: l));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, complainData: r));
    });
  }

  void loadComplainReplies({required int complainId, NetworkStatus submitComplain = NetworkStatus.loading}) async {
    emit(state.copyWith(submitComplain: submitComplain));
    final data = await loadComplainRepliesUseCase(complainId: complainId);
    data.fold((l) {
      emit(state.copyWith(submitComplain: NetworkStatus.success));
    }, (r) {
      emit(state.copyWith(complainReplies: r, submitComplain: NetworkStatus.success));
    });
  }

  void submitComplainReply({required int complainId}) async {
    ComplainReplyBody complainReplyBody = ComplainReplyBody(
        isReply: state.complainReplies.isNotEmpty ? 1 : 0,
        explanation: (state.writeExplanation == true || state.isAgree == false || state.directTalkHR == false)
            ? explanationController.text.isNotEmpty
                ? explanationController.text
                : 'Agreed'
            : 'Direct talk with HR',
        isAppeal: (state.complainReplies.isEmpty || state.isAppeal == true) ? 1 : 0);

    final data = await submitComplainReplyUseCase(body: complainReplyBody, complainId: complainId);
    data.fold((l) {
      emit(state.copyWith(submitComplain: NetworkStatus.success));
    }, (r) {
      loadComplainReplies(complainId: complainId, submitComplain: NetworkStatus.success);
      explanationController.clear();
    });
  }

  Future<bool> submitComplain({required BuildContext context}) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    ComplainBody body = ComplainBody(
        title: titleController.text,
        description: descriptionController.text,
        employeeId: state.employee?.id,
        date: state.date,
        deadline: state.deadline,
        attachment: state.document);
    final data = await submitComplainUseCase(body: body);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, failure: l));
    }, (r) {
      emit(ComplainState(status: NetworkStatus.success, complainData: state.complainData));
      titleController.clear();
      descriptionController.clear();
      _loadComplainData();
      Navigator.pop(context);
    });
    return true;
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
      emit(state.copyWith(status: NetworkStatus.success));
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

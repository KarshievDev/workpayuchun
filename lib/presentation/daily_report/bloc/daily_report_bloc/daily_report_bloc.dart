import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/date_utils.dart';

part 'daily_report_event.dart';
part 'daily_report_state.dart';

typedef DailyReportBlocFactory = DailyReportBloc Function();

class DailyReportBloc extends Bloc<DailyReportEvent, DailyReportState> {
  final LoadDailyReportUseCase loadDailyReportUseCase;
  final SubmitDailyReportUseCase submitDailyReportUseCase;
  final TextEditingController callsMadeController = TextEditingController();
  final TextEditingController positiveLeadsController = TextEditingController();
  final TextEditingController totalSalesController = TextEditingController();
  final TextEditingController pendingAndLeadsOtherNoteController = TextEditingController();
  final TextEditingController recoveryTodayOtherNoteController = TextEditingController();
  final TextEditingController dailyReportSummaryController = TextEditingController();
  final TextEditingController complaintsQuestionsController = TextEditingController();

  DailyReportBloc({required this.loadDailyReportUseCase, required this.submitDailyReportUseCase})
      : super(const DailyReportState(status: NetworkStatus.initial)) {
    on<DailyReportEventLoad>(_onDailyReportLoad);
    on<OnSelectReportDateEvent>(_onSelectReportDate);
    on<OnSelectStartTimeEvent>(_onSelectStartTime);
    on<OnSelectEndTimeEvent>(_onSelectEndTime);
    on<OnDailyReportSubmitEvent>(_onDailyReportSubmit);
    on<OnReviewChangedEvent>(_onReviewChanged);
    on<OnPendingLeadsEvent>(_onPendingLeadsChanged);
    on<OnWorkRecoveryEvent>(_onRecoveryChanged);

    add(DailyReportEventLoad());
  }

  FutureOr<void> _onReviewChanged(OnReviewChangedEvent event, Emitter<DailyReportState> emit) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onDailyReportSubmit(OnDailyReportSubmitEvent event, Emitter<DailyReportState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, fileId: event.fileId));
    final body = SubmitDailyReportBody(
        date: state.reportDate,
        startTime: get24HTime(timeOfDay: state.startTime),
        endTime: get24HTime(timeOfDay: state.endTime),
        callsMade: int.tryParse(callsMadeController.text),
        positiveLeads: int.tryParse(positiveLeadsController.text),
        totalSales: totalSalesController.text,
        pendingAndLeadsOtherNote: pendingAndLeadsOtherNoteController.text,
        recoveryTodayOtherNote: recoveryTodayOtherNoteController.text,
        dailyReportSummary: dailyReportSummaryController.text,
        complaintsQuestionsComments: complaintsQuestionsController.text,
        isUpdatePendingAndLeads: state.pendingLeadsValue,
        isWorkedOnRecoveryToday: state.workedRecoveryValue,
        fileId: state.fileId,
        howWasYourDayMark: state.rating);

    final data = await submitDailyReportUseCase(body: body);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure, errorMsg: l.meaningfulMessage));
    }, (r) {
      emit(state.reset());
      dispose();
      add(DailyReportEventLoad());
      Navigator.pop(event.context);
    });
  }

  void _onSelectReportDate(OnSelectReportDateEvent event, Emitter<DailyReportState> emit) async {
    emit(state.copyWith(reportDate: event.reportDate));
  }

  void _onSelectStartTime(OnSelectStartTimeEvent event, Emitter<DailyReportState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (event.context.mounted) {
      emit(state.copyWith(startTime: result?.format(event.context)));
    }
  }


  FutureOr<void> _onSelectEndTime(OnSelectEndTimeEvent event, Emitter<DailyReportState> emit) async {
    final timeOfDay = getTimeOfDayFromDateTime(time: state.startTime);
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: timeOfDay.replacing(minute: timeOfDay.minute + 1),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (event.context.mounted) {
      emit(state.copyWith(endTime: result?.format(event.context)));
    }
  }

  FutureOr<void> _onDailyReportLoad(DailyReportEventLoad event, Emitter<DailyReportState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final loadDailyReports = await loadDailyReportUseCase();
    loadDailyReports.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(dailyReportListModel: r, status: NetworkStatus.success, errorMsg: null));
    });
  }

  FutureOr<void> _onPendingLeadsChanged(OnPendingLeadsEvent event, Emitter<DailyReportState> emit) {
    emit(state.copyWith(pendingLeadsValue: event.leads));
  }

  FutureOr<void> _onRecoveryChanged(OnWorkRecoveryEvent event, Emitter<DailyReportState> emit) {
    emit(state.copyWith(workedRecoveryValue: event.recovery));
  }

  void dispose() {
    callsMadeController.clear();
    positiveLeadsController.clear();
    totalSalesController.clear();
    pendingAndLeadsOtherNoteController.clear();
    recoveryTodayOtherNoteController.clear();
    dailyReportSummaryController.clear();
    complaintsQuestionsController.clear();
  }
}

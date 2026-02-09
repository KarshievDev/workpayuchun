import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'break_event.dart';

part 'break_state.dart';

class BreakBloc extends Bloc<BreakEvent, BreakState> {
  final MetaClubApiClient metaClubApiClient;
  final int userId;

  BreakBloc({required this.metaClubApiClient, required this.userId})
      : super(const BreakState(status: NetworkStatus.initial)) {
    on<GetBreakInitialData>(_onGetInitialData);
    on<SelectDate>(_onSelectDatePicker);
    on<SelectEmployee>(_selectEmployee);
    on<BreakSummaryDetails>(_onBreakSummaryDetails);
  }

  FutureOr<void> _onGetInitialData(GetBreakInitialData event, Emitter<BreakState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'date': state.currentMonth ?? currentDate};
    final report = await metaClubApiClient.getBreakSummary(body: data);
    report.fold((l) {
      emit(const BreakState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, breakSummaryModel: r));
    });
  }

  FutureOr<void> _onSelectDatePicker(SelectDate event, Emitter<BreakState> emit) async {
    var date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (date != null) {
      String? currentMonth = getDateAsString(format: 'y-MM-d', dateTime: date);
      emit(state.copyWith(status: NetworkStatus.success, currentMonth: currentMonth));
      if (event.isSummaryScreen) {
        add(BreakSummaryDetails());
      } else {
        add(GetBreakInitialData());
      }
    }
  }

  FutureOr<void> _selectEmployee(event, Emitter<BreakState> emit) async {
    emit(state.copyWith(selectEmployee: event.selectEmployee));
    add(BreakSummaryDetails());
  }

  Future<ReportBreakListModel?> getBreakSummaryHistoryList({required String breakUserId}) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final data = {'user_id': breakUserId, 'date': state.currentMonth ?? currentDate};
    final response = await metaClubApiClient.getBreakSummaryList(body: data);
    return response.fold((l) {
      return null;
    }, (r) => r);
  }

  FutureOr<void> _onBreakSummaryDetails(BreakSummaryDetails event, Emitter<BreakState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final data = {'user_id': state.selectEmployee ?? userId, 'date': state.currentMonth ?? currentDate};
    final report = await metaClubApiClient.getBreakSummaryList(body: data);
    report.fold((l) {
      emit(const BreakState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, reportBreakListModel: r));
    });
  }
}

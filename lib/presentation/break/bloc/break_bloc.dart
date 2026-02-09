import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'break_event.dart';

part 'break_state.dart';

typedef BreakBlocFactory = BreakBloc Function();

class BreakBloc extends Bloc<BreakEvent, BreakState> {
  final BreakBackUseCase _breakBackUseCase;
  final BreakBackHistoryUseCase _breakBackHistoryUseCase;
  final BreakBackQRVerifyUseCase _breakBackQRVerifyUseCase;
  final SubmitRemarksUseCase _submitRemarksUseCase;

  BreakBloc({
    required BreakBackUseCase breakBackUseCase,
    required BreakBackHistoryUseCase breakBackHistoryUseCase,
    required BreakBackQRVerifyUseCase breakBackQRVerifyUseCase,
    required SubmitRemarksUseCase submitRemarksUseCase,
  }) : _breakBackUseCase = breakBackUseCase,
       _breakBackHistoryUseCase = breakBackHistoryUseCase,
       _breakBackQRVerifyUseCase = breakBackQRVerifyUseCase,
       _submitRemarksUseCase = submitRemarksUseCase,
       super(const BreakState()) {
    on<OnCustomTimerStart>(_onCustomTimerStart);
    on<OnBreakBackEvent>(_onBreakBack);
    on<RemarkEvent>(_onRemark);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<GetBreakHistoryData>(_onBreakHistoryDataLoad);
    on<OnInitialHistoryEvent>(_onInitialBreakHistory);
    on<BreakVerifyQREvent>(_onVerifyQR);
    on<BreakTypeUpdateEvent>(_onBreakTypeUpdate);
    on<MealUpdateEvent>(_onMealTypeUpdate);
    on<RemarkUpdateEvent>(_onRemarkUpdate);
  }

  FutureOr<void> _onCustomTimerStart(
    OnCustomTimerStart event,
    Emitter<BreakState> emit,
  ) {
    emit(state.copyWith(isTimerStart: !state.isTimerStart));
  }

  FutureOr<void> _onBreakBack(
    OnBreakBackEvent event,
    Emitter<BreakState> emit,
  ) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    final body = {
      "break_type_id": state.selectedBreakType?.id,
      "remark": state.remarks,
      "is_take_meal": state.takeMeal,
    };

    final data = await _breakBackUseCase(body: body);

    data.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        final todayHistories = r?.data?.breakBackHistory ?? [];
        final _ = '${r?.data?.breakTime} - ${r?.data?.backTime ?? ''}';
        final isBreakTaken =
            r?.data?.breakTime != null && r?.data?.backTime == null;

        globalState.set(breakTime, r?.data?.breakTime);
        globalState.set(backTime, r?.data?.backTime);
        globalState.set(isBreak, isBreakTaken);
        globalState.set(hour, '0');
        globalState.set(min, '0');
        globalState.set(sec, '0');

        add(OnCustomTimerStart(hour: 0, min: 0, sec: 0));
        emit(
          state.copyWith(
            status: NetworkStatus.success,
            breakBack: r,
            breaks: todayHistories.reversed.toList(),
          ),
        );
        // add(GetBreakHistoryData());
      },
    );
  }

  FutureOr<void> _onSelectDatePicker(
    SelectDatePicker event,
    Emitter<BreakState> emit,
  ) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentDate = getDateAsString(format: 'yyyy-MM-dd', dateTime: date);
    add(GetBreakHistoryData(date: currentDate));
  }

  FutureOr<void> _onBreakHistoryDataLoad(
    GetBreakHistoryData event,
    Emitter<BreakState> emit,
  ) async {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    emit(
      state.copyWith(status: NetworkStatus.loading, currentDate: event.date),
    );
    final breakReportModelData = await _breakBackHistoryUseCase(
      date: state.currentDate ?? currentDate,
    );
    breakReportModelData.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        if (r != null) {
          final breakReportData = r.data;
          final breakHistory = breakReportData?.breakHistory;
          final todayBreaks = breakHistory?.todayHistory ?? [];
          List<TodayBreakItem> breaks = [];
          if (todayBreaks.isNotEmpty) {
            for (final todayBreak in todayBreaks) {
              breaks.add(
                TodayBreakItem(
                  breakTime: todayBreak.breakBackTime,
                  duration: todayBreak.breakTimeDuration,
                  breakTypeName: todayBreak.name,
                  reason: todayBreak.reason,
                ),
              );
            }
          }

          emit(
            state.copyWith(status: NetworkStatus.success, breakReportModel: r),
          );
        } else {
          emit(state.copyWith(status: NetworkStatus.failure));
        }
      },
    );
  }

  void _onVerifyQR(BreakVerifyQREvent event, Emitter<BreakState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final verifyQrData = await _breakBackQRVerifyUseCase(code: event.code);
    verifyQrData.fold(
      (l) {
        emit(state.copyWith(status: NetworkStatus.failure));
      },
      (r) {
        emit(state.copyWith(verifyQRData: r, status: NetworkStatus.success));
      },
    );
  }

  void _onRemark(RemarkEvent event, Emitter<BreakState> emit) async {
    _submitRemarksUseCase(body: event.body);
    Navigator.pop(event.context);
  }

  void _onBreakTypeUpdate(
    BreakTypeUpdateEvent event,
    Emitter<BreakState> emit,
  ) {
    emit(state.copyWith(selectedBreakType: event.type));
  }

  void _onMealTypeUpdate(MealUpdateEvent event, Emitter<BreakState> emit) {
    emit(state.copyWith(takeMeal: event.takeMeal));
  }

  void _onRemarkUpdate(RemarkUpdateEvent event, Emitter<BreakState> emit) {
    emit(state.copyWith(remarks: event.remark));
  }

  FutureOr<void> _onInitialBreakHistory(
    OnInitialHistoryEvent event,
    Emitter<BreakState> emit,
  ) {
    emit(state.copyWith(breaks: event.breaks?.reversed.toList() ?? []));
  }
}

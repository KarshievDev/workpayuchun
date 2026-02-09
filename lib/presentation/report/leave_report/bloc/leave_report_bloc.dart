import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'leave_report_event.dart';

part 'leave_report_state.dart';

class LeaveReportBloc extends Bloc<LeaveReportEvent, LeaveReportState> {
  final MetaClubApiClient metaClubApiClient;
  final int userId;

  LeaveReportBloc({required this.metaClubApiClient, required this.userId})
      : super(const LeaveReportState(status: NetworkStatus.initial)) {
    on<GetLeaveReportSummary>(_onLeaveReportSummary);
    on<FilterLeaveReportSummary>(_onFilterLeaveReportSummary);
    on<SelectMonthPicker>(_onSelectMonthPicker);
    on<LeaveRequest>(_leaveRequest);
    on<SelectLeaveEmployee>(_selectEmployee);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onLeaveReportSummary(GetLeaveReportSummary event, Emitter<LeaveReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final leaveSummaryData = await metaClubApiClient.leaveReportSummaryApi(state.selectDate ?? currentDate);
    leaveSummaryData.fold((l) {
      emit(const LeaveReportState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, leaveReportSummaryModel: r));
    });
  }

  FutureOr<void> _onFilterLeaveReportSummary(FilterLeaveReportSummary event, Emitter<LeaveReportState> emit) async {
    final leaveSummaryResponse = await metaClubApiClient.leaveSummaryApi(state.selectedEmployee?.id ?? userId);
    leaveSummaryResponse.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(filterLeaveSummaryResponse: r, status: NetworkStatus.success));
    });
  }

  FutureOr<void> _onSelectMonthPicker(SelectMonthPicker event, Emitter<LeaveReportState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (date != null) {
      String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
      emit(state.copyWith(status: NetworkStatus.success, selectMonth: currentMonth));
      add(LeaveRequest());
    }
  }

  FutureOr<void> _selectEmployee(SelectLeaveEmployee event, Emitter<LeaveReportState> emit) async {
    final currentMonth = DateFormat('y-MM', "en").format(DateTime.now());
    emit(state.copyWith(selectedEmployee: event.selectEmployee, selectMonth: state.selectMonth ?? currentMonth));

    add(LeaveRequest());
  }

  FutureOr<void> _leaveRequest(LeaveRequest event, Emitter<LeaveReportState> emit) async {
    final currentMonth = DateFormat('y-MM', "en").format(DateTime.now());
    add(FilterLeaveReportSummary());
    emit(state.copyWith(status: NetworkStatus.loading));
    final leaveRequestResponse = await metaClubApiClient.leaveRequestApi(
        state.selectedEmployee?.id ?? userId, state.selectMonth ?? currentMonth);
    leaveRequestResponse.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(leaveRequestModel: r, status: NetworkStatus.success));
    });
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<LeaveReportState> emit) async {
    try {
      await showDatePicker(
        context: event.context,
        firstDate: DateTime(DateTime.now().year - 1, 5),
        lastDate: DateTime(DateTime.now().year + 1, 9),
        initialDate: DateTime.now(),
        locale: const Locale("en"),
      ).then((value) {
        if (value != null) {
          final currentDate = getDateAsString(format: 'y-M-d', dateTime: value);
          emit(state.copyWith(selectDate: currentDate));
          add(GetLeaveReportSummary());
        }
      });
    } on Exception catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future<LeaveDetailsModel?> onLeaveReportDetails(leaveId) async {
    try {
      final leaveDetailsModel =
          await metaClubApiClient.leaveReportDetailsApi(state.selectedEmployee?.id ?? userId, leaveId);
      return leaveDetailsModel.fold((l) => null, (r) => r);
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future<LeaveDetailsModel?> onLeaveSummaryDetails(leaveUserId, leaveId) async {
    try {
      final leaveDetailsModel = await metaClubApiClient.leaveReportDetailsApi(leaveUserId, leaveId);
      return leaveDetailsModel.fold((l) => null, (r) => r);
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future<LeaveReportTypeWiseSummary?> onTypeWiseLeaveSummary(leaveId) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    try {
      final data = {"date": state.selectDate ?? currentDate, "leave_type": leaveId};
      final leaveDetailsModel = await metaClubApiClient.getLeaveSummaryTypeWise(data);
      return leaveDetailsModel.fold((l) => null, (r) => r);
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }
}

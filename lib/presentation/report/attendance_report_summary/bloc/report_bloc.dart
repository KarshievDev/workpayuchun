import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final MetaClubApiClient metaClubApiClient;
  final int userId;

  ReportBloc({required this.metaClubApiClient, required this.userId})
      : super(const ReportState(status: NetworkStatus.initial)) {
    on<GetReportData>(_onGetReportData);
    on<SelectDate>(_onSelectDatePicker);
    on<SelectEmployee>(_selectEmployee);
    on<GetAttendanceReportData>(_onAttendanceLoad);
  }

  FutureOr<void> _onSelectDatePicker(SelectDate event, Emitter<ReportState> emit) async {
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
      if (event.isEmployeeScreen) {
        add(GetAttendanceReportData());
      } else {
        add(GetReportData());
      }
    }
  }

  FutureOr<void> _onGetReportData(GetReportData event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'date': state.currentMonth ?? currentDate};
    final report = await metaClubApiClient.getAttendanceReportSummary(body: data);
    report.fold((l) {
      emit(const ReportState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, attendanceSummary: r));
    });
  }

  Future<SummaryAttendanceToList?> getSummaryToList({required String type}) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final data = {'type': type, 'date': state.currentMonth ?? currentDate};
    try {
      final response = await metaClubApiClient.getAttendanceSummaryToList(body: data);
      return response.fold((l) => null, (r) => r);
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _selectEmployee(SelectEmployee event, Emitter<ReportState> emit) async {
    emit(state.copyWith(selectEmployee: event.selectEmployee));
    add(GetAttendanceReportData());
  }

  FutureOr<void> _onAttendanceLoad(GetAttendanceReportData event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'month': state.currentMonth ?? currentDate};
    final report = await metaClubApiClient.getAttendanceReport(body: data, userId: state.selectEmployee?.id ?? userId);
    report.fold((l) {
      emit(const ReportState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, attendanceReport: r));
    });
  }

  Future<PhoneBookDetailsModel?> onPhoneBookDetails({required String userId}) async {
    final data = await metaClubApiClient.getPhoneBooksUserDetails(userId: userId);
    return data.fold((l) => null, (r) => r);
  }
}

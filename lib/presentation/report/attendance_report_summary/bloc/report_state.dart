part of 'report_bloc.dart';

class ReportState extends Equatable {
  final int? userId;
  final NetworkStatus? status;
  final String? currentMonth;
  final PhoneBookUser? selectEmployee;
  final ReportAttendanceSummary? attendanceSummary;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;
  final AttendanceReport? attendanceReport;

  const ReportState(
      {this.userId,
      this.status,
      this.currentMonth,
      this.selectEmployee,
      this.attendanceSummary,
      this.leaveReportSummaryModel,
      this.filterLeaveSummaryResponse,
      this.attendanceReport});

  ReportState copyWith(
      {int? userId,
      NetworkStatus? status,
      ReportAttendanceSummary? attendanceSummary,
      PhoneBookUser? selectEmployee,
      LeaveReportSummaryModel? leaveReportSummaryModel,
      LeaveSummaryModel? filterLeaveSummaryResponse,
      String? currentMonth,
      AttendanceReport? attendanceReport}) {
    return ReportState(
        userId: userId ?? this.userId,
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        selectEmployee: selectEmployee ?? this.selectEmployee,
        attendanceSummary: attendanceSummary ?? this.attendanceSummary,
        leaveReportSummaryModel:
            leaveReportSummaryModel ?? this.leaveReportSummaryModel,
        filterLeaveSummaryResponse:
            filterLeaveSummaryResponse ?? this.filterLeaveSummaryResponse,
        attendanceReport: attendanceReport ?? this.attendanceReport);
  }

  @override
  List<Object?> get props => [
        userId,
        status,
        currentMonth,
        attendanceSummary,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse,
        selectEmployee,
        attendanceReport
      ];
}

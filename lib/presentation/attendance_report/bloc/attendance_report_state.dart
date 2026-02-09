part of 'attendance_report_bloc.dart';

class AttendanceReportState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final AttendanceReport? attendanceReport;
  final bool? isDialogOpen;

  const AttendanceReportState(
      {this.status, this.currentMonth, this.attendanceReport, this.isDialogOpen});

  AttendanceReportState copyWith(
      {NetworkStatus? status,
      Filter? filter,
      String? currentMonth,
      AttendanceReport? attendanceReport,
      bool? isDialogOpen}) {
    return AttendanceReportState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        attendanceReport: attendanceReport ?? this.attendanceReport,
        isDialogOpen: isDialogOpen ?? this.isDialogOpen);
  }

  @override
  List<Object?> get props => [status, currentMonth, attendanceReport, isDialogOpen];
}

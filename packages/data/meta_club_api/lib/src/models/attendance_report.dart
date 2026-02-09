import 'package:equatable/equatable.dart';

class AttendanceReport extends Equatable {
  const AttendanceReport({
    this.result,
    this.message,
    this.reportData,
  });

  final bool? result;
  final String? message;
  final AttendanceReportData? reportData;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) =>
      AttendanceReport(
        result: json["result"],
        message: json["message"],
        reportData: AttendanceReportData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, reportData];
}

class AttendanceReportData extends Equatable {
  const AttendanceReportData({
    this.attendanceSummary,
    this.dailyReport,
  });

  final AttendanceSummary? attendanceSummary;
  final List<DailyReport>? dailyReport;

  factory AttendanceReportData.fromJson(Map<String, dynamic> json) =>
      AttendanceReportData(
        attendanceSummary:
            AttendanceSummary.fromJson(json["attendance_summary"]),
        dailyReport: List<DailyReport>.from(
            json["daily_report"].map((x) => DailyReport.fromJson(x))),
      );

  @override
  List<Object?> get props => [attendanceSummary, dailyReport];
}

class AttendanceSummary extends Equatable {
  const AttendanceSummary({
    this.workingDays,
    this.present,
    this.workTime,
    this.absent,
    this.totalOnTimeIn,
    this.totalLeave,
    this.totalEarlyIn,
    this.totalLateIn,
    this.totalLeftTimely,
    this.totalLeftEarly,
    this.totalLeftLater,
  });

  final String? workingDays;
  final String? present;
  final String? workTime;
  final String? absent;
  final String? totalOnTimeIn;
  final String? totalLeave;
  final String? totalEarlyIn;
  final String? totalLateIn;
  final String? totalLeftTimely;
  final String? totalLeftEarly;
  final String? totalLeftLater;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      AttendanceSummary(
        workingDays: json["working_days"],
        present: json["present"],
        workTime: json["work_time"],
        absent: json["absent"],
        totalOnTimeIn: json["total_on_time_in"],
        totalLeave: json["total_leave"],
        totalEarlyIn: json["total_early_in"],
        totalLateIn: json["total_late_in"],
        totalLeftTimely: json["total_left_timely"],
        totalLeftEarly: json["total_left_early"],
        totalLeftLater: json["total_left_later"],
      );


  @override
  List<Object?> get props => [
        workingDays,
        present,
        workTime,
        absent,
        totalOnTimeIn,
        totalLeave,
        totalEarlyIn,
        totalLateIn,
        totalLeftTimely,
        totalLeftEarly,
        totalLeftLater
      ];
}

class DailyReport extends Equatable {
  const DailyReport({
    this.fullDate,
    this.weekDay,
    this.date,
    this.status,
    this.remoteModeIn,
    this.remoteModeOut,
    this.checkIn,
    this.checkInStatus,
    this.checkOutStatus,
    this.checkInLocation,
    this.checkInReason,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutReason,
    this.multipleAttendance,
  });

  final String? fullDate;
  final String? weekDay;
  final String? date;
  final String? status;
  final String? remoteModeIn;
  final String? remoteModeOut;
  final String? checkIn;
  final String? checkInStatus;
  final String? checkOutStatus;
  final String? checkInLocation;
  final String? checkInReason;
  final String? checkOut;
  final String? checkOutLocation;
  final String? checkOutReason;
  final MultipleAttendance? multipleAttendance;

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        fullDate: json["full_date"],
        weekDay: json["week_day"],
        date: json["date"],
        status: json["status"],
        remoteModeIn: json["remote_mode_in"],
        remoteModeOut: json["remote_mode_out"],
        checkIn: json["check_in"],
        checkInStatus: json["check_in_status"],
        checkOutStatus: json["check_out_status"],
        checkInLocation: json["check_in_location"],
        checkInReason: json["check_in_reason"],
        checkOut: json["check_out"],
        checkOutLocation: json["check_out_location"],
        checkOutReason: json["check_out_reason"],
        multipleAttendance: json["multiple_attendance"] == null
            ? null
            : MultipleAttendance.fromJson(json["multiple_attendance"]),
      );

  @override
  List<Object?> get props => [
        fullDate,
        weekDay,
        date,
        status,
        remoteModeIn,
        remoteModeOut,
        checkIn,
        checkInStatus,
        checkOutStatus,
        checkInLocation,
        checkInReason,
        checkOut,
        checkOutLocation,
        checkOutReason,
        multipleAttendance
      ];
}

class MultipleAttendance extends Equatable {
  final String? date;
  final List<DailyReport>? dateWiseReport;

  const MultipleAttendance({
    this.date,
    this.dateWiseReport,
  });

  factory MultipleAttendance.fromJson(Map<String, dynamic> json) =>
      MultipleAttendance(
        date: json["date"],
        dateWiseReport: json["date_wise_report"] == null
            ? []
            : List<DailyReport>.from(
                json["date_wise_report"]!.map((x) => DailyReport.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        date,
        dateWiseReport,
      ];
}

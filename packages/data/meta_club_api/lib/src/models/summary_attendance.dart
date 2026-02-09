import 'package:equatable/equatable.dart';

class ReportAttendanceSummary extends Equatable {
  const ReportAttendanceSummary({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final SummaryOfAttendanceData? data;

  factory ReportAttendanceSummary.fromJson(Map<String, dynamic> json) =>
      ReportAttendanceSummary(
        result: json["result"],
        message: json["message"],
        data: SummaryOfAttendanceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [result, message, data];
}

class SummaryOfAttendanceData extends Equatable {
  const SummaryOfAttendanceData({
    this.date,
    this.attendanceSummary,
  });

  final String? date;
  final ReportOfAttendanceSummary? attendanceSummary;

  factory SummaryOfAttendanceData.fromJson(Map<String, dynamic> json) =>
      SummaryOfAttendanceData(
        date: json["date"],
        attendanceSummary:
            ReportOfAttendanceSummary.fromJson(json["attendance_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "attendance_summary": attendanceSummary!.toJson(),
      };

  @override
  List<Object?> get props => [date, attendanceSummary];
}

class ReportOfAttendanceSummary extends Equatable {
  const ReportOfAttendanceSummary({
    this.present,
    this.absent,
    this.onTimeIn,
    this.leave,
    this.earlyIn,
    this.lateIn,
    this.leftTimely,
    this.leftEarly,
    this.leftLater,
  });

  final String? present;
  final String? absent;
  final String? onTimeIn;
  final String? leave;
  final String? earlyIn;
  final String? lateIn;
  final String? leftTimely;
  final String? leftEarly;
  final String? leftLater;

  factory ReportOfAttendanceSummary.fromJson(Map<String, dynamic> json) =>
      ReportOfAttendanceSummary(
        present: json["present"],
        absent: json["absent"],
        onTimeIn: json["on_time_in"],
        leave: json["leave"],
        earlyIn: json["early_in"],
        lateIn: json["late_in"],
        leftTimely: json["left_timely"],
        leftEarly: json["left_early"],
        leftLater: json["left_later"],
      );

  Map<String, dynamic> toJson() => {
        "present": present,
        "absent": absent,
        "on_time_in": onTimeIn,
        "leave": leave,
        "early_in": earlyIn,
        "late_in": lateIn,
        "left_timely": leftTimely,
        "left_early": leftEarly,
        "left_later": leftLater,
      };

  @override
  List<Object?> get props => [
        present,
        absent,
        onTimeIn,
        leave,
        earlyIn,
        lateIn,
        leftTimely,
        leftEarly,
        leftLater
      ];
}

import 'package:equatable/equatable.dart';

class LeaveReportSummaryModel extends Equatable {
  const LeaveReportSummaryModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final LeaveSummaryReportData? data;

  factory LeaveReportSummaryModel.fromJson(Map<String, dynamic> json) =>
      LeaveReportSummaryModel(
        result: json["result"],
        message: json["message"],
        data: LeaveSummaryReportData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class LeaveSummaryReportData extends Equatable {
  const LeaveSummaryReportData({
    this.date,
    this.leaveTypes,
  });

  final String? date;
  final List<LeaveReportSummaryType>? leaveTypes;

  factory LeaveSummaryReportData.fromJson(Map<String, dynamic> json) =>
      LeaveSummaryReportData(
        date: json["date"],
        leaveTypes: List<LeaveReportSummaryType>.from(
            json["leave_types"].map((x) => LeaveReportSummaryType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "leave_types": List<dynamic>.from(leaveTypes!.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [date, leaveTypes];
}

class LeaveReportSummaryType extends Equatable {
  const LeaveReportSummaryType({
    this.id,
    this.name,
    this.count,
  });

 final dynamic id;
 final String? name;
 final int? count;

  factory LeaveReportSummaryType.fromJson(Map<String, dynamic> json) =>
      LeaveReportSummaryType(
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
  @override
  List<Object?> get props => [id, name, count];
}

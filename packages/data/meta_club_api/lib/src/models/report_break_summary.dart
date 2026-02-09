import 'package:equatable/equatable.dart';

class ReportBreakSummaryModel extends Equatable {
  const ReportBreakSummaryModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final BreakSummaryData? data;

  factory ReportBreakSummaryModel.fromJson(Map<String, dynamic> json) =>
      ReportBreakSummaryModel(
        result: json["result"],
        message: json["message"],
        data: BreakSummaryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class BreakSummaryData extends Equatable {
  const BreakSummaryData({
    this.date,
    this.employeeList,
  });

  final String? date;
  final List<EmployeeList>? employeeList;

  factory BreakSummaryData.fromJson(Map<String, dynamic> json) =>
      BreakSummaryData(
        date: json["date"],
        employeeList: List<EmployeeList>.from(
            json["employee_list"].map((x) => EmployeeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "employee_list":
            List<dynamic>.from(employeeList!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [date, employeeList];
}

class EmployeeList extends Equatable {
  const EmployeeList({
    this.userId,
    this.name,
    this.designation,
    this.avatarId,
    this.totalBreakTime,
  });

  final int? userId;
  final String? name;
  final String? designation;
  final String? avatarId;
  final String? totalBreakTime;

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
        userId: json["user_id"],
        name: json["name"],
        designation: json["designation"],
        avatarId: json["avatar_id"],
        totalBreakTime: json["total_break_time"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "designation": designation,
        "avatar_id": avatarId,
        "total_break_time": totalBreakTime,
      };

  @override
  List<Object?> get props =>
      [userId, name, designation, avatarId, totalBreakTime];
}

import 'package:equatable/equatable.dart';

class SelectEmployeeLeaveModel extends Equatable {
  const SelectEmployeeLeaveModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final SelectedEmployeeDataList? data;

  factory SelectEmployeeLeaveModel.fromJson(Map<String, dynamic> json) =>
      SelectEmployeeLeaveModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] != null
            ? SelectedEmployeeDataList.fromJson(json["data"])
            : null,
      );
  @override
  List<Object?> get props => [result, message, data];
}

class SelectedEmployeeDataList extends Equatable {
  const SelectedEmployeeDataList({
    this.availableLeave,
  });

  final List<SelectedEmployeeRequestLeave>? availableLeave;

  factory SelectedEmployeeDataList.fromJson(Map<String, dynamic> json) =>
      SelectedEmployeeDataList(
        availableLeave: json['leaveRequests'] != null
            ? List<SelectedEmployeeRequestLeave>.from(
                json["leaveRequests"]
                    .map((x) => SelectedEmployeeRequestLeave.fromJson(x)),
              )
            : null,
      );
  @override
  List<Object?> get props => [availableLeave];
}

class SelectedEmployeeRequestLeave extends Equatable {
  final int? id;
  final String? type;
  final int? days;
  final String? status;
  final String? applyDate;
  final String? colorCode;

  const SelectedEmployeeRequestLeave(
      {this.id,
      this.type,
      this.days,
      this.status,
      this.applyDate,
      this.colorCode});

  factory SelectedEmployeeRequestLeave.fromJson(Map<String, dynamic> json) =>
      SelectedEmployeeRequestLeave(
          id: json['id'],
          type: json['type'],
          days: int.parse(json['days'].toString()),
          status: json['status'],
          applyDate: json['apply_date'],
          colorCode: json['color_code']);

  @override
  List<Object?> get props => [id, type, days, status, applyDate, colorCode];
}
// int.parse(json["company_id"].toString()
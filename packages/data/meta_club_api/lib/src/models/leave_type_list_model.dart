import 'package:equatable/equatable.dart';

class LeaveTypeListModel extends Equatable {
  final bool? result;
  final String? message;
  final LeaveListData? data;

  const LeaveTypeListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeaveTypeListModel.fromJson(Map<String, dynamic> json) =>
      LeaveTypeListModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : LeaveListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class LeaveListData extends Equatable {
  final List<LeaveListDatum>? data;

  const LeaveListData({
    this.data,
  });

  factory LeaveListData.fromJson(Map<String, dynamic> json) => LeaveListData(
        data: json["data"] == null
            ? []
            : List<LeaveListDatum>.from(
                json["data"]!.map((x) => LeaveListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [data];
}

class LeaveListDatum {
  final int? id;
  final String? date;
  final String? staff;
  final String? avater;
  final String? designation;
  final String? leaveType;
  final String? time;
  final String? reason;
  final ApprovalDetails? approvalDetails;
  final String? tlApprovalMsg;
  final String? status;

  const LeaveListDatum({
    this.id,
    this.date,
    this.staff,
    this.avater,
    this.designation,
    this.leaveType,
    this.time,
    this.reason,
    this.approvalDetails,
    this.tlApprovalMsg,
    this.status,
  });

  factory LeaveListDatum.fromJson(Map<String, dynamic> json) => LeaveListDatum(
        id: json["id"],
        date: json["date"],
        staff: json["staff"],
        avater: json["avater"],
        designation: json["designation"],
        leaveType: json["leave_type"],
        time: json["time"],
        reason: json["reason"],
        approvalDetails: json["approval_details"] == null
            ? null
            : ApprovalDetails.fromJson(json["approval_details"]),
        tlApprovalMsg: json["tl_approval_msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "staff": staff,
        "avater": avater,
        "designation": designation,
        "leave_type": leaveType,
        "time": time,
        "reason": reason,
        "approval_details": approvalDetails?.toJson(),
        "tl_approval_msg": tlApprovalMsg,
        "status": status,
      };
  List<Object?> get props => [
        id,
        date,
        staff,
        avater,
        designation,
        leaveType,
        time,
        reason,
        approvalDetails,
        tlApprovalMsg,
        status
      ];
}

class ApprovalDetails extends Equatable {
  final dynamic managerApproval;
  final dynamic hrApproval;

  const ApprovalDetails({
    this.managerApproval,
    this.hrApproval,
  });

  factory ApprovalDetails.fromJson(Map<String, dynamic> json) =>
      ApprovalDetails(
        managerApproval: json["manager_approval"],
        hrApproval: json["hr_approval"],
      );

  Map<String, dynamic> toJson() => {
        "manager_approval": managerApproval,
        "hr_approval": hrApproval,
      };

  @override
  List<Object?> get props => [managerApproval, hrApproval];
}

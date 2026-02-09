import 'package:equatable/equatable.dart';

class ApprovalModel extends Equatable {
  const ApprovalModel({
    this.result,
    this.message,
    this.approvalData,
  });

  final bool? result;
  final String? message;
  final ApprovalData? approvalData;

  factory ApprovalModel.fromJson(Map<String, dynamic> json) =>
      ApprovalModel(
        result: json["result"],
        message: json["message"],
        approvalData: ApprovalData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": approvalData!.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [result, message, approvalData];
}

class ApprovalData extends Equatable {
  const ApprovalData({
    this.leaveRequests,
  });

  final List<ApprovalLeaveRequest>? leaveRequests;

  factory ApprovalData.fromJson(Map<String, dynamic> json) => ApprovalData(
        leaveRequests: List<ApprovalLeaveRequest>.from(
            json["leaveRequests"].map((x) => ApprovalLeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leaveRequests":
            List<dynamic>.from(leaveRequests!.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [leaveRequests];
}

class ApprovalLeaveRequest extends Equatable {
  const ApprovalLeaveRequest({
    this.id,
    this.userId,
    this.name,
    this.message,
    this.type,
    this.days,
    this.applyDate,
    this.dateDuration,
    this.status,
    this.colorCode,
  });

  final int? id;
  final int? userId;
  final String? name;
  final String? message;
  final String? type;
  final int? days;
  final String? applyDate;
  final String? dateDuration;
  final String? status;
  final String? colorCode;

  factory ApprovalLeaveRequest.fromJson(Map<String, dynamic> json) =>
      ApprovalLeaveRequest(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        message: json["message"],
        type: json["type"],
        days: json["days"],
        applyDate: json["apply_date"],
        dateDuration: json["date_duration"],
        status: json["status"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "message": message,
        "type": type,
        "days": days,
        "apply_date": applyDate,
        "date_duration": dateDuration,
        "status": status,
        "color_code": colorCode,
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        message,
        type,
        days,
        applyDate,
        dateDuration,
        status,
        colorCode
      ];
}

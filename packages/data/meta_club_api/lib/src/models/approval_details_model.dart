import 'package:equatable/equatable.dart';

class ApprovalDetailsModel extends Equatable {
  const ApprovalDetailsModel({
    this.result,
    this.message,
    this.approvalDetailsData,
  });

  final bool? result;
  final String? message;
  final ApprovalDetailsData? approvalDetailsData;

  factory ApprovalDetailsModel.fromJson(Map<String, dynamic> json) =>
      ApprovalDetailsModel(
        result: json["result"],
        message: json["message"],
        approvalDetailsData: ApprovalDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": approvalDetailsData!.toJson(),
      };

  @override
  List<Object?> get props => [result, message, approvalDetailsData];
}

class ApprovalDetailsData extends Equatable {
  const ApprovalDetailsData({
    this.id,
    this.userId,
    this.requestedOn,
    this.name,
    this.designation,
    this.department,
    this.type,
    this.period,
    this.totalDays,
    this.note,
    this.availableLeave,
    this.totalUsed,
    this.approvedBy,
    this.referredBy,
    this.status,
    this.colorCode,
    this.substitute,
    this.apporover,
    this.attachment,
  });

  final int? id;
  final int? userId;
  final String? requestedOn;
  final String? name;
  final String? designation;
  final String? department;
  final String? type;
  final String? period;
  final int? totalDays;
  final String? note;
  final int? availableLeave;
  final int? totalUsed;
  final String? approvedBy;
  final String? referredBy;
  final String? status;
  final String? colorCode;
  final Substitute? substitute;
  final String? apporover;
  final String? attachment;

  factory ApprovalDetailsData.fromJson(Map<String, dynamic> json) =>
      ApprovalDetailsData(
        id: json["id"],
        userId: json["user_id"],
        requestedOn: json["requested_on"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"],
        type: json["type"],
        period: json["period"],
        totalDays: json["total_days"],
        note: json["note"],
        availableLeave: json["available_leave"],
        totalUsed: json["total_used"],
        approvedBy: json["approved_by"],
        referredBy: json["referred_by"],
        status: json["status"],
        colorCode: json["color_code"],
        substitute: json["substitute"] != null
            ? Substitute.fromJson(json["substitute"])
            : null,
        apporover: json["apporover"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requested_on": requestedOn,
        "type": type,
        "period": period,
        "total_days": totalDays,
        "note": note,
        "available_leave": availableLeave,
        "total_used": totalUsed,
        "approved_by": approvedBy,
        "referred_by": referredBy,
        "status": status,
        "color_code": colorCode,
        "substitute": substitute!.toJson(),
        "apporover": apporover,
        "attachment": attachment,
      };

  @override
  List<Object?> get props => [
        id,
        requestedOn,
        type,
        period,
        totalDays,
        note,
        availableLeave,
        totalUsed,
        approvedBy,
        referredBy,
        status,
        colorCode,
        substitute,
        apporover,
        attachment,
      ];
}

class Substitute extends Equatable {
  const Substitute({
    this.id,
    this.name,
    this.employeeId,
    this.designation,
    this.avatar,
  });

  final int? id;
  final String? name;
  final String? employeeId;
  final String? designation;
  final String? avatar;

  factory Substitute.fromJson(Map<String, dynamic> json) => Substitute(
        id: json["id"],
        name: json["name"],
        employeeId: json["employee_id"],
        designation: json["designation"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "employee_id": employeeId,
        "designation": designation,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        employeeId,
        designation,
        avatar
      ];
}

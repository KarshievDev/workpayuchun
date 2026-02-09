import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class LeaveDetailsModel extends Equatable {
  final bool? result;
  final String? message;
  final LeaveDetailsData? leaveDetailsData;

  const LeaveDetailsModel({this.result, this.message, this.leaveDetailsData});

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) =>
      LeaveDetailsModel(
        result: json["result"],
        message: json["message"],
        leaveDetailsData:
            json["data"] == null
                ? null
                : LeaveDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": leaveDetailsData?.toJson(),
  };

  @override
  List<Object?> get props => [result, message, leaveDetailsData];
}

class LeaveDetailsData extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? designation;
  final String? department;
  final dynamic employeeId;
  final String? requestedOn;
  final String? type;
  final String? period;
  final int? totalDays;
  final String? note;
  final dynamic apporover;
  final int? availableLeave;
  final int? totalUsed;
  final String? approvedBy;
  final String? referredBy;
  final LeaveStatusEnum? status;
  final String? colorCode;
  final dynamic substitute;
  final String? attachment;
  final String? imageUrl;

  const LeaveDetailsData({
    this.id,
    this.userId,
    this.name,
    this.designation,
    this.department,
    this.employeeId,
    this.requestedOn,
    this.type,
    this.period,
    this.totalDays,
    this.note,
    this.apporover,
    this.availableLeave,
    this.totalUsed,
    this.approvedBy,
    this.referredBy,
    this.status,
    this.colorCode,
    this.substitute,
    this.attachment,
    this.imageUrl,
  });

  factory LeaveDetailsData.fromJson(Map<String, dynamic> json) =>
      LeaveDetailsData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"],
        employeeId: json["employee_id"],
        requestedOn: json["requested_on"],
        type: json["type"],
        period: json["period"],
        totalDays: json["total_days"],
        note: json["note"],
        apporover: json["apporover"],
        availableLeave: json["available_leave"],
        totalUsed: json["total_used"],
        approvedBy: json["approved_by"],
        referredBy: json["referred_by"],
        status: LeaveStatusEnum.fromString(json["status"]),
        colorCode: json["color_code"],
        substitute: json["substitute"],
        attachment: json["attachment"],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "designation": designation,
    "department": department,
    "employee_id": employeeId,
    "requested_on": requestedOn,
    "type": type,
    "period": period,
    "total_days": totalDays,
    "note": note,
    "apporover": apporover,
    "available_leave": availableLeave,
    "total_used": totalUsed,
    "approved_by": approvedBy,
    "referred_by": referredBy,
    "status": status?.name,
    "color_code": colorCode,
    "substitute": substitute,
    "attachment": attachment,
    "image_url": imageUrl,
  };

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    designation,
    department,
    employeeId,
    requestedOn,
    type,
    period,
    totalDays,
    note,
    apporover,
    availableLeave,
    totalUsed,
    approvedBy,
    referredBy,
    status,
    colorCode,
    substitute,
    attachment,
    imageUrl,
  ];
}

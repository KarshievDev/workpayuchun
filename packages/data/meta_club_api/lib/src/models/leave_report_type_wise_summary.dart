import 'package:equatable/equatable.dart';

class LeaveReportTypeWiseSummary extends Equatable {
  const LeaveReportTypeWiseSummary({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final LeaveTypeSummaryData? data;

  factory LeaveReportTypeWiseSummary.fromJson(Map<String, dynamic> json) =>
      LeaveReportTypeWiseSummary(
        result: json["result"],
        message: json["message"],
        data: LeaveTypeSummaryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class LeaveTypeSummaryData extends Equatable {
  const LeaveTypeSummaryData({
    this.leaves,
  });

  final List<SummaryLeaveDetails>? leaves;

  factory LeaveTypeSummaryData.fromJson(Map<String, dynamic> json) =>
      LeaveTypeSummaryData(
        leaves: List<SummaryLeaveDetails>.from(
            json["leaves"].map((x) => SummaryLeaveDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leaves": List<dynamic>.from(leaves!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [leaves];
}

class SummaryLeaveDetails extends Equatable {
  const SummaryLeaveDetails({
    this.id,
    this.userId,
    this.userName,
    this.avatar,
    this.userDesignation,
    this.days,
    this.reason,
  });

  final int? id;
  final int? userId;
  final String? userName;
  final String? avatar;
  final String? userDesignation;
  final int? days;
  final String? reason;

  factory SummaryLeaveDetails.fromJson(Map<String, dynamic> json) =>
      SummaryLeaveDetails(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        avatar: json["avatar"],
        userDesignation: json["user_designation"],
        days: json["days"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "avatar": avatar,
        "user_designation": userDesignation,
        "days": days,
        "reason": reason,
      };

  @override
  List<Object?> get props =>
      [id, userId, userName, avatar, userDesignation, days, reason];
}

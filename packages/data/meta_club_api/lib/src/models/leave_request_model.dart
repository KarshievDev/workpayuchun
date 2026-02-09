import 'package:equatable/equatable.dart';

class LeaveRequestModel extends Equatable{
  final bool? result;
  final String? message;
  final LeaveRequestData? leaveRequestData;

  const LeaveRequestModel({
    this.result,
    this.message,
    this.leaveRequestData,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) => LeaveRequestModel(
    result: json["result"],
    message: json["message"],
    leaveRequestData: json["data"] == null ? null : LeaveRequestData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": leaveRequestData?.toJson(),
      };

  @override
  List<Object?> get props => [result,message,leaveRequestData];

}

class LeaveRequestData extends Equatable{
  final List<LeaveRequestValue>? leaveRequests;

  const LeaveRequestData({
    this.leaveRequests,
  });

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) => LeaveRequestData(
    leaveRequests: json["leaveRequests"] == null ? [] : List<LeaveRequestValue>.from(json["leaveRequests"]!.map((x) => LeaveRequestValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
        "leaveRequests": leaveRequests?.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [leaveRequests];
}

class LeaveRequestValue extends Equatable{
  final int? id;
  final String? type;
  final int? days;
  final String? applyDate;
  final String? status;
  final String? colorCode;

  const LeaveRequestValue({
    this.id,
    this.type,
    this.days,
    this.applyDate,
    this.status,
    this.colorCode,
  });

  factory LeaveRequestValue.fromJson(Map<String, dynamic> json) => LeaveRequestValue(
    id: json["id"],
    type: json["type"],
    days: json["days"],
    applyDate: json["apply_date"],
    status: json["status"],
    colorCode: json["color_code"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "days": days,
        "apply_date": applyDate,
        "status": status,
        "color_code": colorCode,
      };

  @override
  List<Object?> get props => [id,type,days,applyDate,status,colorCode];

}

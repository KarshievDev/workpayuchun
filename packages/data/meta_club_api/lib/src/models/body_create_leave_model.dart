class BodyCreateLeaveModel {
  int? userId;
  int? substituteId;
  int? assignLeaveId;
  String? applyDate;
  String? leaveFrom;
  String? leaveTo;
  String? reason;
  String? imageUrl;

  BodyCreateLeaveModel(
      {this.userId,
      this.substituteId,
      this.assignLeaveId,
      this.applyDate,
      this.leaveFrom,
      this.leaveTo,
      this.reason,
      this.imageUrl});

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "substitute_id": substituteId,
        "leave_type_id": assignLeaveId,
        "apply_date": applyDate,
        "leave_from": leaveFrom,
        "leave_to": leaveTo,
        "reason": reason,
        "image_url": imageUrl
      };
}

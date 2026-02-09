class BodyCreateDailyLeaveModel {
  String? reason;
  String? time;

  BodyCreateDailyLeaveModel({this.reason, this.time});

  Map<String, dynamic> toJson() => {"reason": reason, "time": time};
}

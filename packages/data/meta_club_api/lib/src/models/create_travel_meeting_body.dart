class CreateTravelMeetingBody {
  int? travelPlanId;
  String? date;
  String? meetingScheduleTime;
  String? meetingStartTime;
  String? meetingEndTime;
  String? customerCompanyName;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? purpose;
  String? remark;
  int? fileId;
  int? rating;


  CreateTravelMeetingBody({
    this.travelPlanId,
    this.date,
    this.meetingScheduleTime,
    this.meetingStartTime,
    this.meetingEndTime,
    this.customerCompanyName,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.purpose,
    this.remark,
    this.fileId,
    this.rating,

  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["travel_plan_id"] = travelPlanId;
    map["date"] = date;
    map["meeting_schedule_time"] = meetingScheduleTime;
    map["meeting_start_time"] = meetingStartTime;
    map["meeting_end_time"] = meetingEndTime;
    map["customer_company_name"] = customerCompanyName;
    map["customer_name"] = customerName;
    map["customer_email"] = customerEmail;
    map["customer_phone"] = customerPhone;
    map["purpose"] = purpose;
    map["remark"] = remark;
    map["file_id"] = fileId;
    map["rating"] = rating;
    return map;
  }

}

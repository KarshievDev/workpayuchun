class TravelMeetingModel {
  bool? result;
  String? message;
  MeetingResponse? data;

  TravelMeetingModel({
    this.result,
    this.message,
    this.data,
  });

  factory TravelMeetingModel.fromJson(Map<String, dynamic> json) => TravelMeetingModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : MeetingResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class MeetingResponse {
  List<MeetingData>? data;
  MeetingLinks? links;
  MeetingMeta? meta;

  MeetingResponse({
    this.data,
    this.links,
    this.meta,
  });

  factory MeetingResponse.fromJson(Map<String, dynamic> json) => MeetingResponse(
    data: json["data"] == null ? [] : List<MeetingData>.from(json["data"]!.map((x) => MeetingData.fromJson(x))),
    links: json["links"] == null ? null : MeetingLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : MeetingMeta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class MeetingData {
  int? id;
  int? travelPlanId;
  MeetingEmployee? employee;
  DateTime? date;
  String? meetingScheduleTime;
  String? meetingStartTime;
  String? meetingEndTime;
  String? totalMeetingTime;
  String? customerCompanyName;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? purpose;
  String? remark;
  String? file;
  int? rating;

  MeetingData({
    this.id,
    this.travelPlanId,
    this.employee,
    this.date,
    this.meetingScheduleTime,
    this.meetingStartTime,
    this.meetingEndTime,
    this.totalMeetingTime,
    this.customerCompanyName,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.purpose,
    this.remark,
    this.file,
    this.rating,
  });

  factory MeetingData.fromJson(Map<String, dynamic> json) => MeetingData(
    id: json["id"],
    travelPlanId: json["travel_plan_id"],
    employee: json["employee"] == null ? null : MeetingEmployee.fromJson(json["employee"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    meetingScheduleTime: json["meeting_schedule_time"],
    meetingStartTime: json["meeting_start_time"],
    meetingEndTime: json["meeting_end_time"],
    totalMeetingTime: json["total_meeting_time"],
    customerCompanyName: json["customer_company_name"],
    customerName: json["customer_name"],
    customerEmail: json["customer_email"],
    customerPhone: json["customer_phone"],
    purpose: json["purpose"],
    remark: json["remark"],
    file: json["file"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "travel_plan_id": travelPlanId,
    "employee": employee?.toJson(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "meeting_schedule_time": meetingScheduleTime,
    "meeting_start_time": meetingStartTime,
    "meeting_end_time": meetingEndTime,
    "total_meeting_time": totalMeetingTime,
    "customer_company_name": customerCompanyName,
    "customer_name": customerName,
    "customer_email": customerEmail,
    "customer_phone": customerPhone,
    "purpose": purpose,
    "remark": remark,
    "file": file,
    "rating": rating,
  };
}

class MeetingEmployee {
  int? id;
  String? name;
  String? department;
  String? designation;
  String? avatar;

  MeetingEmployee({
    this.id,
    this.name,
    this.department,
    this.designation,
    this.avatar,
  });

  factory MeetingEmployee.fromJson(Map<String, dynamic> json) => MeetingEmployee(
    id: json["id"],
    name: json["name"],
    department: json["department"],
    designation: json["designation"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "department": department,
    "designation": designation,
    "avatar": avatar,
  };
}

class MeetingLinks {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  MeetingLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory MeetingLinks.fromJson(Map<String, dynamic> json) => MeetingLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class MeetingMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<MeetingLink>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MeetingMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory MeetingMeta.fromJson(Map<String, dynamic> json) => MeetingMeta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<MeetingLink>.from(json["links"]!.map((x) => MeetingLink.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class MeetingLink {
  String? url;
  String? label;
  bool? active;

  MeetingLink({
    this.url,
    this.label,
    this.active,
  });

  factory MeetingLink.fromJson(Map<String, dynamic> json) => MeetingLink(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

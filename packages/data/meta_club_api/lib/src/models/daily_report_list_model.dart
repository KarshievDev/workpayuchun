
class DailyReportListModel {
  bool? result;
  String? message;
  DailyReportListData? data;

  DailyReportListModel({
    this.result,
    this.message,
    this.data,
  });

  factory DailyReportListModel.fromJson(Map<String, dynamic> json) => DailyReportListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : DailyReportListData.fromJson(json["data"]),
  );

}

class DailyReportListData {
  List<UserDailyReport>? data;
  DailyReportLinks? links;
  DailyReportMeta? meta;

  DailyReportListData({
    this.data,
    this.links,
    this.meta,
  });

  factory DailyReportListData.fromJson(Map<String, dynamic> json) => DailyReportListData(
    data: json["data"] == null ? [] : List<UserDailyReport>.from(json["data"]!.map((x) => UserDailyReport.fromJson(x))),
    links: json["links"] == null ? null : DailyReportLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : DailyReportMeta.fromJson(json["meta"]),
  );

}

class UserDailyReport {
  int? id;
  DailyReportEmployeeInfo? employee;
  DateTime? date;
  String? startTime;
  String? endTime;
  String? totalTime;
  int? callsMade;
  int? positiveLeads;
  String? totalSales;
  String? isUpdatePendingAndLeads;
  dynamic pendingAndLeadsOtherNote;
  String? isWorkedOnRecoveryToday;
  dynamic recoveryTodayOtherNote;
  String? dailyReportSummary;
  dynamic complaintsQuestionsComments;
  dynamic file;
  int? howWasYourDayMark;

  UserDailyReport({
    this.id,
    this.employee,
    this.date,
    this.startTime,
    this.endTime,
    this.totalTime,
    this.callsMade,
    this.positiveLeads,
    this.totalSales,
    this.isUpdatePendingAndLeads,
    this.pendingAndLeadsOtherNote,
    this.isWorkedOnRecoveryToday,
    this.recoveryTodayOtherNote,
    this.dailyReportSummary,
    this.complaintsQuestionsComments,
    this.file,
    this.howWasYourDayMark,
  });

  factory UserDailyReport.fromJson(Map<String, dynamic> json) => UserDailyReport(
    id: json["id"],
    employee: json["employee"] == null ? null : DailyReportEmployeeInfo.fromJson(json["employee"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    totalTime: json["total_time"],
    callsMade: json["calls_made"],
    positiveLeads: json["positive_leads"],
    totalSales: json["total_sales"],
    isUpdatePendingAndLeads: json["is_update_pending_and_leads"],
    pendingAndLeadsOtherNote: json["pending_and_leads_other_note"],
    isWorkedOnRecoveryToday: json["is_worked_on_recovery_today"],
    recoveryTodayOtherNote: json["recovery_today_other_note"],
    dailyReportSummary: json["daily_report_summary"],
    complaintsQuestionsComments: json["complaints_questions_comments"],
    file: json["file"],
    howWasYourDayMark: json["how_was_your_day_mark"],
  );
}

class DailyReportEmployeeInfo {
  int? id;
  String? name;
  String? department;
  String? designation;
  String? avatar;

  DailyReportEmployeeInfo({
    this.id,
    this.name,
    this.department,
    this.designation,
    this.avatar,
  });

  factory DailyReportEmployeeInfo.fromJson(Map<String, dynamic> json) => DailyReportEmployeeInfo(
    id: json["id"],
    name: json["name"],
    department: json["department"],
    designation: json["designation"],
    avatar: json["avatar"],
  );
}

class DailyReportLinks {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  DailyReportLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory DailyReportLinks.fromJson(Map<String, dynamic> json) => DailyReportLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );
}

class DailyReportMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<DailyReportLink>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  DailyReportMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory DailyReportMeta.fromJson(Map<String, dynamic> json) => DailyReportMeta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<DailyReportLink>.from(json["links"]!.map((x) => DailyReportLink.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );
}

class DailyReportLink {
  String? url;
  String? label;
  bool? active;

  DailyReportLink({
    this.url,
    this.label,
    this.active,
  });

  factory DailyReportLink.fromJson(Map<String, dynamic> json) => DailyReportLink(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

}

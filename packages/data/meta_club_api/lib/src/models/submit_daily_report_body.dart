class SubmitDailyReportBody {
  String? date;
  String? startTime;
  String? endTime;
  int? callsMade;
  int? positiveLeads;
  String? totalSales;
  String? isUpdatePendingAndLeads;
  String? pendingAndLeadsOtherNote;
  String? isWorkedOnRecoveryToday;
  String? recoveryTodayOtherNote;
  String? dailyReportSummary;
  String? complaintsQuestionsComments;
  int? fileId;
  int? howWasYourDayMark;

  SubmitDailyReportBody({
    this.date,
    this.startTime,
    this.endTime,
    this.callsMade,
    this.positiveLeads,
    this.totalSales,
    this.isUpdatePendingAndLeads,
    this.pendingAndLeadsOtherNote,
    this.isWorkedOnRecoveryToday,
    this.recoveryTodayOtherNote,
    this.dailyReportSummary,
    this.complaintsQuestionsComments,
    this.fileId,
    this.howWasYourDayMark,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    map["start_time"] = startTime;
    map["end_time"] = endTime;
    map["calls_made"] = callsMade;
    map["positive_leads"] = positiveLeads;
    map["total_sales"] = totalSales;
    map["is_update_pending_and_leads"] = isUpdatePendingAndLeads;
    map["pending_and_leads_other_note"] = pendingAndLeadsOtherNote;
    map["is_worked_on_recovery_today"] = isWorkedOnRecoveryToday;
    map["recovery_today_other_note"] = recoveryTodayOtherNote;
    map["daily_report_summary"] = dailyReportSummary;
    map["complaints_questions_comments"] = complaintsQuestionsComments;
    map["file_id"] = fileId;
    map["how_was_your_day_mark"] = howWasYourDayMark;
    return map;
  }
}

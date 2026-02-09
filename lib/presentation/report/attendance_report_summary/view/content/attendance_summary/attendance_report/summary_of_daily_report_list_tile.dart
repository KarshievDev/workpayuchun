import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../../../attendance_report/view/content/pending_attendance_today.dart';
import '../../../../../../attendance_report/view/view.dart';
import 'present_attendance_tile.dart';

class SummaryOfDailyReportListTile extends StatelessWidget {
  final DailyReport dailyReport;
  final bool? isReportSummary;

  const SummaryOfDailyReportListTile(
      {super.key, required this.dailyReport, this.isReportSummary});

  @override
  Widget build(BuildContext context) {
    switch (dailyReport.status) {
      case "Present":
        return PresentAttendanceTile(dailyReport: dailyReport);
      case "Absent":
        return AbsentContent(dailyReport: dailyReport);
      case "Weekend":
        return WeekendContent(dailyReport: dailyReport);
      case "Holiday":
        return HolidayContent(
          dailyReport: dailyReport,
        );
      case "...":
        return PendingAttendanceToday(dailyReport: dailyReport);
        // return isReportSummary == true
        //     ? const SizedBox()
        //     : PendingAttendanceToday(dailyReport: dailyReport);
      default:
        return const SizedBox.shrink();
    }
  }
}

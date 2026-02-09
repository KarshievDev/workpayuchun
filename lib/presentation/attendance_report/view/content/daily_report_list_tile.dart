import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/pending_attendance_today.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/present_content.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/weekend_content.dart';
import 'absent_content.dart';
import 'holiday_content.dart';

class DailyReportListTile extends StatelessWidget {
  final DailyReport dailyReport;

  final Settings settings;

  const DailyReportListTile(
      {super.key,
      required this.dailyReport,
      required this.settings});

  @override
  Widget build(BuildContext context) {
    switch (dailyReport.status) {
      case "Present":
        return DailyReportTile(dailyReport: dailyReport, settings: settings);
      case "Absent":
        return AbsentContent(dailyReport: dailyReport);
      case "Weekend":
        return WeekendContent(dailyReport: dailyReport);
      case "Holiday":
        return HolidayContent(dailyReport: dailyReport,);
      case "...":
        return PendingAttendanceToday(dailyReport: dailyReport);
      default:
        return const SizedBox.shrink();
    }
  }
}

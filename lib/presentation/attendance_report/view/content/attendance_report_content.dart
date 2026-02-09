import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/attendance_report/bloc/attendance_report_bloc.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/summery_tile.dart';

class AttendanceReportContent extends StatelessWidget {
  const AttendanceReportContent({super.key, required this.bloc});
  final AttendanceReportBloc bloc;

  @override
  Widget build(BuildContext context) {
    final attendanceSummery =
        bloc.state.attendanceReport?.reportData?.attendanceSummary;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Column(
          children: [
            SummeryTile(
                titleValue: attendanceSummery?.workingDays ?? '',
                title: 'working_days',
                color: colorPrimary),
            SummeryTile(
                titleValue: attendanceSummery?.totalOnTimeIn ?? '',
                title: 'on_time',
                color: Colors.green),
            SummeryTile(
                titleValue: attendanceSummery?.totalLateIn ?? '',
                title: 'late',
                color: Colors.red),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftTimely ?? '',
                title: 'left_timely',
                color: Colors.green),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftEarly ?? '',
                title: 'left_early',
                color: Colors.red),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeave ?? '',
                title: 'on_leave',
                color: Colors.grey[400]!),
            SummeryTile(
                titleValue: attendanceSummery?.absent ?? '',
                title: 'absent',
                color: Colors.black87),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftLater ?? '',
                title: 'left_later',
                color: Colors.amber),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../attendance_report/view/content/summery_tile.dart';
import '../../../../bloc/report_bloc.dart';

class AttendanceSummaryTile extends StatelessWidget {
  const AttendanceSummaryTile({super.key});

  @override
  Widget build(BuildContext context) {
    final reportBloc = context.watch<ReportBloc>();
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.workingDays,
              title: 'working_days',
              color: Colors.green),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalOnTimeIn,
              title: 'on_time',
              color: Colors.green),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalLateIn,
              title: 'late',
              color: Colors.red),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalLeftTimely,
              title: 'left_timely',
              color: Colors.green),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalLeftEarly,
              title: 'left_early',
              color: Colors.red),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalLeave,
              title: 'on_leave',
              color: Colors.grey[400]!),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.absent,
              title: 'absent',
              color: Colors.black87),
          SummeryTile(
              titleValue: reportBloc.state.attendanceReport?.reportData
                  ?.attendanceSummary?.totalLeftLater,
              title: 'left_later',
              color: Colors.amber),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

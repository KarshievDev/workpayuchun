import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/attendance_report/bloc/attendance_report_bloc.dart';


class PlutoAttendanceReportContent extends StatelessWidget {
  const PlutoAttendanceReportContent({super.key, required this.bloc});
  final AttendanceReportBloc bloc;

  @override
  Widget build(BuildContext context) {
    final attendanceSummery = bloc.state.attendanceReport?.reportData?.attendanceSummary;
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisExtent: 80,
        crossAxisSpacing: 8.0,mainAxisSpacing: 8.0
      ),
      padding: const EdgeInsets.all(20.0),

    children: <Widget> [
      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("working_days".tr()),
            Text(attendanceSummery?.workingDays ?? '',style: TextStyle(color: Branding.colors.primaryLight,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("on_time".tr()),
            Text(attendanceSummery?.totalOnTimeIn ?? '',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
          ],
        ),
      ),

      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("late".tr()),
            Text(attendanceSummery?.totalLateIn ?? '',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
          ],
        ),
      ),

      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("left_timely".tr()),
            Text(attendanceSummery?.totalLeftTimely ?? '',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
          ],
        ),
      ),

      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("left_early".tr()),
            Text(attendanceSummery?.totalLeftEarly ?? '',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("on_leave".tr()),
            Text(attendanceSummery?.totalLeave ?? '',style: TextStyle(color: Colors.grey[400]!,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("absent".tr()),
            Text(attendanceSummery?.absent ?? '',style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight.withValues(alpha: 0.5)),borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("left_later".tr()),
            Text(attendanceSummery?.absent ?? '',style: const TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    ],);
  }
}

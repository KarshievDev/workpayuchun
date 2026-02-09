import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../../report.dart';
import 'attendance_summary/attendance_summary_content.dart';
import 'content.dart';

class ReportContent extends StatelessWidget {
  const ReportContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: ListView(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                NavUtil.navigateScreen(context, const AttendanceSummaryContent());
              },
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/menu_report/report_attendance.png',
                      height: 28.r,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      tr('attendance'),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14.r),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              NavUtil.navigateScreen(context, const BreakReportSummary());
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/menu_report/report_break.png',
                      height: 30.r,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      tr("break"),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14.r),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              NavUtil.navigateScreen(context, const LeaveSummeryScreen());
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () {
                  NavUtil.navigateScreen(context, const LeaveSummeryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/menu_report/report_leave.png',
                        height: 28.r,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        tr('leave'),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14.r),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

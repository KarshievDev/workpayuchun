import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class DailyReportCard extends StatelessWidget {
  const DailyReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () {
            NavUtil.navigateScreen(context, const DailyReportPage());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(CupertinoIcons.calendar,size: 45.sp,color: Branding.colors.primaryLight),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "Daily",
                          style: TextStyle(
                              fontSize: 16.r, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0.5)),
                      Text("Report",
                        style: TextStyle(
                            color: Branding.colors.primaryLight,
                            fontSize: 16.r,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

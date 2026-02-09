import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class PendingAttendanceToday extends StatelessWidget {
  const PendingAttendanceToday({
    super.key,
    required this.dailyReport,
  });

  final DailyReport dailyReport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Column(
              children: [
                Text(
                  dailyReport.weekDay ?? "",
                  style: TextStyle(color: Colors.black54, fontSize: 12.r),
                ),
                Text(
                  dailyReport.date ?? "",
                  style: TextStyle(color: Colors.black54, fontSize: DeviceUtil.isTablet ? 20.sp : 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  color: const Color(0xffF2F8FF),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            strokeWidth: 1,
                            child: Text(
                              dailyReport.status ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: DeviceUtil.isTablet ? 20.sp : 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

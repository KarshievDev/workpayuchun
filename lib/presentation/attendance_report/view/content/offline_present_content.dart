import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/common/functions.dart';
import '../../../../res/common/toast.dart';

class DailyOfflineReportTile extends StatelessWidget {
  final AttendanceBody dailyReport;

  const DailyOfflineReportTile({super.key, required this.dailyReport});

  @override
  Widget build(BuildContext context) {

    // remote mode In -> Home or Office
    final mode = (dailyReport.mode == 0) ? "Home" : "Office";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Column(
              children: [
                Text(mode.tr(), style: TextStyle(color: Colors.black54, fontSize: 20.r),
                ),
                Text(
                  getDDMMYYYYAsString(date: dailyReport.date ?? '',outputFormat: 'dd MMM yyyy',inputFormat: 'yyyy-MM-dd') ?? "",
                  style: TextStyle(color: Colors.black54, fontSize: 12.r),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffF2F8FF),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Text(
                          "IN",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0.w),
                      Visibility(
                        visible: dailyReport.inTime?.isNotEmpty == true,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(getInOutColor(status: dailyReport.inTime))),
                                  style: BorderStyle.solid,
                                  width: 3.0.w,
                                ),
                                color: Color(int.parse(getInOutColor())),
                                borderRadius: BorderRadius.circular(8.0.r),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5.r),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 3.h),
                                strokeWidth: 1.r,
                                child: Text(
                                  dailyReport.inTime ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.r,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Visibility(
                              visible: dailyReport.reason?.isNotEmpty == true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.reason);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: 18.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffFCF6FF),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Text(
                          "OUT",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(width:12.0.w),
                      Visibility(
                        visible: dailyReport.outTime?.isNotEmpty == true,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(getInOutColor(status: dailyReport.outTime))),
                                  style: BorderStyle.solid,
                                  width: 3.0.w,
                                ),
                                color: Color(int.parse(getInOutColor())),
                                borderRadius: BorderRadius.circular(8.0.r),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5.r),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 3.h),
                                strokeWidth: 1.r,
                                child: Text(
                                  dailyReport.outTime ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.r,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Visibility(
                              visible: dailyReport.reason?.isNotEmpty == true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.reason);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: 18.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

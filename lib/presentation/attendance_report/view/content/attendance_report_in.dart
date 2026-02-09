import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AttendanceReportIn extends StatelessWidget {
  final DailyReport? dateWiseReport;
  final String? checkInColor;
  final String? remoteModeIn;

  const AttendanceReportIn(
      {super.key, this.dateWiseReport, this.checkInColor, this.remoteModeIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      color: const Color(0xffF2F8FF),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Text("IN", style: TextStyle(fontSize: 10.sp)),
          ),
          SizedBox(
            width: 20.w,
          ),
          Visibility(
            visible: dateWiseReport?.checkIn?.isNotEmpty == true,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(int.parse(checkInColor ?? "0xFF000000")),
                      style: BorderStyle.solid,
                      width: 3.0.r,
                    ),
                    color: Color(int.parse(checkInColor ?? "0xFF000000")),
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: DottedBorder(
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5.r),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    strokeWidth: 1,
                    child: Text(
                      dateWiseReport?.checkIn ?? "",
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
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: dateWiseReport?.checkInLocation ?? "No Data Found",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0.r);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blueAccent),
                      child: Center(
                          child: Text(
                        remoteModeIn ?? "H",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.r,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                Visibility(
                  visible: dateWiseReport?.checkInReason?.isNotEmpty == true,
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: dateWiseReport?.checkInReason ?? "No Data Found",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 18.0.r);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.article_outlined,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),
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

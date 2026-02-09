import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/attendance_report_out.dart';
import 'package:strawberryhrm/res/widgets/check_status_color.dart';
import 'attendance_report_in.dart';

class DialogMultiAttendanceList extends StatelessWidget {
  final DailyReport? dailyReport;

  const DialogMultiAttendanceList({super.key, this.dailyReport});

  @override
  Widget build(BuildContext context) {
    String? checkInColor;
    String? checkOutColor;
    return SizedBox(
      height: 300.0.h, // Change as per your requirement
      width: 300.0.w, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dailyReport?.multipleAttendance?.dateWiseReport?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          DailyReport? dateWiseReport = dailyReport?.multipleAttendance?.dateWiseReport?[index];

          /// CheckIn Status Color
          checkInColor = checkInStatusColor(dateWiseReport, checkInColor);

          /// CheckOut Status Color
          checkOutColor = checkOutStatusColor(dateWiseReport, checkOutColor);
          return Column(
            children: [
              AttendanceReportIn(
                dateWiseReport: dateWiseReport,
                checkInColor: checkInColor,
                remoteModeIn: (int.tryParse(dateWiseReport?.remoteModeIn ?? "0") == 0) ? "H" : "V",
              ),
              const SizedBox(height: 5),
              AttendanceReportOut(
                dateWiseReport: dateWiseReport,
                checkOutColor: checkOutColor,
                remoteModeOut: (int.tryParse(dateWiseReport?.remoteModeOut ?? "0") == 0) ? "H" : "V",
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

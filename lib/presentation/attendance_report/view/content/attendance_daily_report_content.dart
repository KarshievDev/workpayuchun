import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance_report/bloc/attendance_report_bloc.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/content.dart';
import 'package:strawberryhrm/res/shimmers.dart' show TileShimmer;
import 'package:user_repository/user_repository.dart';

class AttendanceDailyReportContent extends StatelessWidget {
  const AttendanceDailyReportContent(
      {super.key,
      required this.bloc,
      required this.user,
      required this.settings});
  final AttendanceReportBloc bloc;
  final LoginData user;
  final Settings settings;

  @override
  Widget build(BuildContext context) {
    final listOfDailyReport =
        bloc.state.attendanceReport?.reportData?.dailyReport;
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            tr("daily_report"),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.r),
          )),
          const SizedBox(
            height: 20,
          ),

          listOfDailyReport != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listOfDailyReport.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = listOfDailyReport[index];
                    return DailyReportListTile(
                      dailyReport: data,
                      settings: settings,
                    );
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TileShimmer(
                        titleHeight: 30.h,
                        isSubTitle: true,
                      ),
                    );
                  },
                ),

          /// Bottom =========================

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                  child: Center(
                      child: Text(
                    tr("h"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.r,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  tr("check_in_check_out_from_home"),
                  style: TextStyle(fontSize: 10.r, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                  child: Center(
                      child: Text(
                    tr("v"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.r,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  tr("check_in_check_out_from_office"),
                  style: TextStyle(fontSize: 10.r, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child: Row(
              children: [
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.fileLines,
                      size: 15.r,
                      color: Colors.blueAccent,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (kDebugMode) {
                        print("Pressed");
                      }
                    }),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  tr("reason_for_late_check_in_early_check_out"),
                  style: TextStyle(fontSize: 10.r, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

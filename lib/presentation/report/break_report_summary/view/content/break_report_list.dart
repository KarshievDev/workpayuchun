import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/report/break_report_summary/break_report.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class BreakReportList extends StatelessWidget {
  const BreakReportList({
    super.key,
    required this.breakUserId,
  });

  final String breakUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
        child: AppBar(
          iconTheme:  IconThemeData(
              size: DeviceUtil.isTablet ? 40 : 30,
              color: Colors.white
          ),
          title: Text(tr('break_time_report'),style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
        ),
      ),
      body: FutureBuilder(
        future: context
            .read<BreakBloc>()
            .getBreakSummaryHistoryList(breakUserId: breakUserId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final breakHistory =
                snapshot.data?.data?.breakHistory?.todayHistory;
            return Column(
              children: [
                Container(
                  color: const Color(0xff6AB026),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: DeviceUtil.isTablet ? 10.h : 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: DeviceUtil.isTablet ? 20.r : 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${tr('total_break_time')}:",
                        style: GoogleFonts.nunitoSans(
                            fontSize: DeviceUtil.isTablet ? 16.sp : 16, color: Colors.white),
                      ),
                      // ),
                       SizedBox(
                        width: DeviceUtil.isTablet ? 5.w :5,
                      ),
                      Text(
                        snapshot.data?.data?.totalBreakTime ?? '',
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: DeviceUtil.isTablet ? 14.sp : 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "digitalNumber"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: breakHistory?.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = breakHistory?[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  data?.breakTimeDuration ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 14)
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: DeviceUtil.isTablet ? 40.h : 40,
                                width: DeviceUtil.isTablet ?  3.h : 3,
                                color: colorPrimary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    "break",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: DeviceUtil.isTablet ? 14.sp : 14)
                                  ).tr(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(data?.breakBackTime ?? '',style: TextStyle(fontSize: DeviceUtil.isTablet ? 12.sp : 12),),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TileShimmer(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

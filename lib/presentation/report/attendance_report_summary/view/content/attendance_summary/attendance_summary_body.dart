import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/summery_tile.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';
import '../../../bloc/report_bloc.dart';
import 'attendance_report/attendance_report_employee.dart';
import 'body_to_list_details.dart';

class AttendanceSummaryBody extends StatelessWidget {
  const AttendanceSummaryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (BuildContext context, state) {
        final summaryData = state.attendanceSummary?.data;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
            child: AppBar(
              iconTheme:  IconThemeData(
                  size: DeviceUtil.isTablet ? 40 : 30,
                  color: Colors.white
              ),
              title: Text('attendance_summary'.tr(),style: TextStyle(fontSize: 14.r),),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<ReportBloc>().add(SelectDate(context, false));
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                summaryData != null ? ListTile(
                        title: Text(
                          summaryData.date ?? "",
                          style: TextStyle(fontSize: 14.r)
                        ),
                      )
                    : TileShimmer(
                        titleHeight: DeviceUtil.isTablet ?  16.sp : 16,
                      ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(context,
                              BlocProvider.value(value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'On_time', type: 'on_time_in'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.onTimeIn,
                          title: 'on_time',
                          color: Colors.green),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'late', type: 'late_in'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.lateIn,
                          title: 'late',
                          color: Colors.red),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'left_timely', type: 'left_timely'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.leftTimely,
                          title: 'left_timely',
                          color: Colors.green),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'left_early', type: 'left_early'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.leftEarly,
                          title: 'left_early',
                          color: Colors.red),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'on_leave', type: 'leave'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.leave,
                          title: 'on_leave',
                          color: Colors.grey[400]!),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'absent', type: 'absent'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.absent,
                          title: 'absent',
                          color: Colors.black87),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'left_later', type: 'left_later'),
                              ),
                            );
                          },
                          titleValue: summaryData?.attendanceSummary?.leftLater,
                          title: 'left_later',
                          color: Colors.amber),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40.r,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      NavUtil.navigateScreen(
                        context,
                        BlocProvider.value(
                            value: context.read<ReportBloc>(),
                            child: const AttendanceReportEmployeeContent()),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24.r,
                    ),
                    //icon data for elevated button
                    label:  Text(
                      "search_all_employee_attendance",
                      style: TextStyle(color: Colors.white,fontSize: 14.r),
                    ).tr(),
                    //label text
                    style: ElevatedButton.styleFrom(
                        fixedSize:  Size(400.r, 50.r),
                        backgroundColor: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

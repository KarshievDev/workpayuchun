import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/report_bloc.dart';
import 'attendance_summary_tile.dart';
import 'daily_report_tile.dart';
import 'select_employee.dart';

class AttendanceReportEmployeeContent extends StatelessWidget {
  const AttendanceReportEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (BuildContext context, state) {
        context.read<ReportBloc>().add(GetAttendanceReportData());
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80.0 : 50),
            child: AppBar(
              iconTheme:  const IconThemeData(

                  color: Colors.white
              ),
              title:  Text('attendance_of_employee',style: TextStyle(fontSize: 14.r),).tr(),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<ReportBloc>().add(SelectDate(context, true));
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SelectEmployeeForAttendance(),
                  const AttendanceSummaryTile(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    tr('daily_report'),
                    style:  TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.r),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  const DailyReportTile()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

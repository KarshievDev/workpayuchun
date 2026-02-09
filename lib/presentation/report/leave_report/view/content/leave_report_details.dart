import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/leave/view/content/build_container.dart';
import 'package:strawberryhrm/presentation/report/leave_report/bloc/leave_report_bloc.dart';

class LeaveReportDetailsScreen extends StatelessWidget {
  final int leaveId;

  const LeaveReportDetailsScreen({super.key, required this.leaveId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
              iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
              title: Text(
                "leave_details".tr(),
                style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),
              ))),
      body: FutureBuilder(
        future: context.read<LeaveReportBloc>().onLeaveReportDetails(leaveId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final leaveReportData = snapshot.data?.leaveDetailsData;
            return Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        width: DeviceUtil.isTablet ? 130.w : 130,
                        child: Text(
                          tr("status"),
                          style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
                        )),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(int.parse(leaveReportData?.colorCode ?? "0xFFFFFF")),
                          style: BorderStyle.solid,
                          width: DeviceUtil.isTablet ? 3.0.w : 3.0,
                        ),
                        color: Color(int.parse(leaveReportData?.colorCode ?? "")),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DottedBorder(
                        color: Colors.white,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        strokeWidth: 1,
                        child: Text(
                          '${leaveReportData?.status?.status}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: DeviceUtil.isTablet ? 10.sp : 10,
                              fontWeight: FontWeight.w600),
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ),
              BuildContainer(title: tr("requested_on"), titleValue: leaveReportData?.requestedOn ?? ""),
              BuildContainer(title: tr("type"), titleValue: leaveReportData?.type ?? ""),
              BuildContainer(title: tr("period"), titleValue: leaveReportData?.period ?? ""),
              BuildContainer(title: tr("total_days"), titleValue: '${leaveReportData?.totalDays ?? ""} ${tr("days")}'),
              BuildContainer(
                title: tr("note"),
                titleValue: leaveReportData?.note ?? "",
              ),
              BuildContainer(
                title: tr("substitute"),
                titleValue: leaveReportData?.name ?? tr("add_substitute"),
              ),
              BuildContainer(
                title: tr("approves"),
                titleValue: leaveReportData?.apporover,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: DeviceUtil.isTablet ? 130.w : 130,
                        child: Text(
                          tr("attachment"),
                          style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              )
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

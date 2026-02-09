import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/report/leave_report/leave_report.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class LeaveTypeWiseSummary extends StatelessWidget {
  const LeaveTypeWiseSummary({super.key, required this.leaveData});

  final LeaveReportSummaryType leaveData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
            iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
            title: Text(leaveData.name ?? '',style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
          ),
        ),
        body: FutureBuilder(
          future: context.read<LeaveReportBloc>().onTypeWiseLeaveSummary(leaveData.id),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final leavesData = snapshot.data?.data?.leaves;
              return leavesData?.isNotEmpty == true
                  ? ListView.builder(
                      itemCount: leavesData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = leavesData?[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                    context,
                                    BlocProvider.value(
                                      value: context.read<LeaveReportBloc>(),
                                      child: LeaveSummaryDetails(
                                        leaveId: data!.id!,
                                        userId: data.userId!,
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data?.avatar ??
                                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                ),
                                title: Text(data?.userName ?? '',style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?.userDesignation ?? '',
                                      style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
                                    ),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'reason : ',
                                            style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14)
                                          ).tr(),
                                          Expanded(
                                            child: Text(
                                              data?.reason ?? '',
                                              style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14)
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                                trailing: Text("${data?.days} day",style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const NoDataFoundWidget();
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return const TileShimmer();
                },
              );
            }
          },
        ));
  }
}

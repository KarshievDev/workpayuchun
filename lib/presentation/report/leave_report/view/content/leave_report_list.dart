import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/leave_report/bloc/leave_report_bloc.dart';
import 'package:strawberryhrm/presentation/report/leave_report/view/view.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';

import 'leave_report_details.dart';

class LeaveReportList extends StatelessWidget {
  const LeaveReportList({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveBloc = context.watch<LeaveReportBloc>();
    if (leaveBloc.state.leaveRequestModel != null) {
      return leaveBloc.state.leaveRequestModel?.leaveRequestData?.leaveRequests
                  ?.isNotEmpty ==
              true
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: leaveBloc.state.leaveRequestModel?.leaveRequestData
                      ?.leaveRequests?.length ??
                  0,
              itemBuilder: (context, index) {
                final data = leaveBloc.state.leaveRequestModel?.leaveRequestData
                    ?.leaveRequests?[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            NavUtil.navigateScreen(
                                context,
                                BlocProvider.value(
                                    value: context.read<LeaveReportBloc>(),
                                    child: LeaveReportDetailsScreen(
                                      leaveId: data!.id!,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            data?.type ?? "${tr('leave')}: ",
                                            style:  TextStyle(
                                                fontSize: DeviceUtil.isTablet ? 12.sp : 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ).tr(),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            data?.days.toString() ?? tr('days'),
                                            style:  TextStyle(
                                                fontSize: DeviceUtil.isTablet ? 12.sp : 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data?.applyDate ?? '',
                                        style:  TextStyle(fontSize: DeviceUtil.isTablet ? 10.sp : 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: DeviceUtil.isTablet ? 80.sp : 80,
                                  decoration: BoxDecoration(
                                    color:
                                        Color(int.parse(data?.colorCode ?? '')),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DottedBorder(
                                    color: Colors.white,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: DeviceUtil.isTablet ? 8.w :8, vertical: DeviceUtil.isTablet ? 5.h : 5),
                                    strokeWidth: 1,
                                    child: Center(
                                      child: Text(
                                        data?.status ?? '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: DeviceUtil.isTablet ? 10.sp : 10,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : const Center(
              child: NoDataFoundWidget(),
            );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: RectangularCardShimmer(
              height: 55,
              width: double.infinity,
            ),
          );
        },
      );
    }
  }
}

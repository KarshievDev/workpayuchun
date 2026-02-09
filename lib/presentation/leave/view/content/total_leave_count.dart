import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';

class TotalLeaveCount extends StatelessWidget {
  const TotalLeaveCount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("total_leaves".tr(),
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 12.r : 12,
                                color: Colors.grey))
                        .tr()
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.leaveSummaryModel?.leaveSummaryData?.totalLeave
                          .toString() ??
                      "0",
                  style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 25.r : 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                          color: colorPrimary, shape: BoxShape.circle),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "leaves_used".tr(),
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 12.r : 12,
                          color: Colors.grey),
                    ).tr()
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.leaveSummaryModel?.leaveSummaryData?.totalUsed
                          .toString() ??
                      "0",
                  style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 25.r : 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}

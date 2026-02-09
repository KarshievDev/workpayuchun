import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_list_model.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/content/daily_leave_tile.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/content/leave_type_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class DailyLeavePending extends StatelessWidget {
  const DailyLeavePending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final pending = dailyLeaveBloc
        .state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.pending;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            "pending_leave",
            style: TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ).tr(),
        ),
        const SizedBox(
          height: 8,
        ),
        DailyLeaveTile(
          onTap: () {
            NavUtil.navigateScreen(
              context,
              BlocProvider.value(
                  value: context.read<DailyLeaveBloc>(),
                  child: LeaveTypeScreen(
                    appBarName: "early_leave".tr(),
                    leaveListData: LeaveListModel(
                        userId: user!.user!.id!.toString(),
                        month: dailyLeaveBloc.state.currentMonth ??
                            DateFormat('y-MM-dd').format(DateTime.now()),
                        leaveStatus: 'pending',
                        leaveType: "early_leave"),
                  )),
            );
          },
          title: 'early_leave'.tr(),
          value: pending?.earlyLeave.toString() ?? '',
          color: Colors.yellow,
        ),
        DailyLeaveTile(
          onTap: () {
            NavUtil.navigateScreen(
              context,
              BlocProvider.value(
                  value: context.read<DailyLeaveBloc>(),
                  child: LeaveTypeScreen(
                    appBarName: "late_leave".tr(),
                    leaveListData: LeaveListModel(
                        userId: user!.user!.id!.toString(),
                        month: dailyLeaveBloc.state.currentMonth ??
                            DateFormat('y-MM-dd').format(DateTime.now()),
                        leaveStatus: 'pending',
                        leaveType: "late_arrive"),
                  )),
            );
          },
          title: 'late_leave'.tr(),
          value: pending?.lateArrive.toString() ?? '',
          color: Colors.yellow,
        ),
      ],
    );
  }
}

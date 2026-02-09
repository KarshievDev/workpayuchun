import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/model/leave_list_model.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_daily_leave_tile.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_leave_type_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class PlutoDailyLeaveApproved extends StatelessWidget {
  const PlutoDailyLeaveApproved({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final approved = dailyLeaveBloc.state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.approved;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h,),
        Padding(padding: const EdgeInsets.only(left: 4.0),
          child: Text("approved_leave", style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold, color: Branding.colors.textPrimary),).tr(),),
        SizedBox(height: 8.h,),
        Row(
          children: [
            Expanded(
              child: PlutoDailyLeaveTile(
                onTap: () {
                  NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<DailyLeaveBloc>(),
                        child: PlutoLeaveTypeScreen(appBarName: "early_leave",
                          leaveListData: LeaveListModel(userId: user!.user!.id!.toString(), month: dailyLeaveBloc.state.currentMonth ?? DateFormat('y-MM-dd').format(DateTime.now()), leaveStatus: 'approved', leaveType: "early_leave"),)),);
                },
                title: 'early_leave'.tr(), value: approved?.earlyLeave.toString() ?? '', color: Colors.green,
              ),
            ),
            SizedBox(width: 12.w,),
            Expanded(
              child: PlutoDailyLeaveTile(
                onTap: () {
                  NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<DailyLeaveBloc>(),
                        child: PlutoLeaveTypeScreen(appBarName: "late_leave".tr(), leaveListData: LeaveListModel(userId: user!.user!.id!.toString(), month: dailyLeaveBloc.state.currentMonth ?? DateFormat('y-MM-dd').format(DateTime.now()), leaveStatus: 'approved', leaveType: "late_arrive"),)),
                  );
                },
                title: 'late_leave'.tr(), value: approved?.lateArrive.toString() ?? '', color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
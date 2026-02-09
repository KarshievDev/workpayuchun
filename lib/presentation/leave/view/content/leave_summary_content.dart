import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/attendance/content/animated_circular_button.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/leave_request_list.dart';
import 'package:strawberryhrm/presentation/leave/view/content/total_leave_count.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_type/leave_request_type.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../../attendance/tab_content/tab_animated_circular_button.dart';
class LeaveSummaryContent extends StatelessWidget {
  final LeaveState? state;

  const LeaveSummaryContent({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80.0 : 50),
        child: AppBar(
          iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
          title: Text(
            "leave_summary".tr(),
            style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.r : 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<LeaveBloc>().add(SelectDatePicker(user!.user!.id!, context));
                },
                icon: const Icon(Icons.calendar_month_outlined))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            DeviceUtil.isTablet
                ? TabAnimatedCircularButton(
                    onComplete: () {
                      NavUtil.navigateScreen(context,
                          BlocProvider.value(value: context.read<LeaveBloc>(), child: const LeaveRequestType()));
                    },
                    title: "apply_leave".tr(),
                    color: Branding.colors.primaryLight,
                  )
                : AnimatedHalfCircularButton(
                    onComplete: () {
                      NavUtil.navigateScreen(context,
                          BlocProvider.value(value: context.read<LeaveBloc>(), child: const LeaveRequestType()));
                    },
                    title: "apply_leave".tr(),
                    color: Branding.colors.primaryLight),
            const SizedBox(
              height: 8,
            ),
            Center(
                child: Text(
              "tab_to_apply_for_leave".tr(),
              style: TextStyle(fontSize: DeviceUtil.isTablet ? 12.r : 12, color: Colors.grey),
            ).tr()),
            const SizedBox(
              height: 25.0,
            ),
            const TotalLeaveCount(),
            Center(
                child: Text("leave_request".tr(),
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: DeviceUtil.isTablet ? 20.0.r : 20.0))),
            const SizedBox(
              height: 25.0,
            ),
            LeaveRequestList(userId: user!.user!.id!)
          ],
        ),
      ),
    );
  }
}

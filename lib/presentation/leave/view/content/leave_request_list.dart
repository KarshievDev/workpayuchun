import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/leave/bloc/leave_bloc/leave_bloc.dart';
import 'build_leave_title.dart';
import 'general_list_shimmer.dart';

class LeaveRequestList extends StatelessWidget {
  final int userId;
  const LeaveRequestList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GeneralListShimmer(),
        );
      } else if (state.status == NetworkStatus.success) {
        return state.leaveRequestModel?.leaveRequestData?.leaveRequests?.isNotEmpty == true
            ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.leaveRequestModel?.leaveRequestData?.leaveRequests?.length ?? 0,
                itemBuilder: (context, index) {
                  LeaveRequestValue? leaveRequest = state.leaveRequestModel?.leaveRequestData?.leaveRequests?[index];
                  return BuildLeaveTitle(
                    leaveRequestValue: leaveRequest,
                    userId: userId,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),
              )
            : const NoDataFoundWidget();
      } else if (state.status == NetworkStatus.failure) {
        return Center(
          child: Text(
            "failed_to_load_leave_list".tr(),
            style: TextStyle(
                color: colorPrimary.withValues(alpha: 0.4),
                fontSize: DeviceUtil.isTablet ? 18.sp : 18,
                fontWeight: FontWeight.w500),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:core/core.dart';

import '../../../../attendance/attendance.dart';

class CheckInOutStatusActionMars extends StatelessWidget {
  const CheckInOutStatusActionMars({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardModel = context.watch<HomeBloc>().state.dashboardModel;
    final offlineState = context.watch<OfflineCubit>().state;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryBorderColor),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, AttendancePage.route());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    offlineState.isCheckedIn == offlineState.isCheckedOut
                        ? 'assets/home_icon/in.svg'
                        : 'assets/home_icon/out.svg',
                    height: 40.h,
                    width: 40.w,
                    placeholderBuilder:
                        (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator(),
                        ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offlineState.isCheckedIn == offlineState.isCheckedOut
                            ? "start_time".tr()
                            : "done_for_today".tr(),
                        style: const TextStyle(
                          color: colorPrimary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        offlineState.isCheckedIn == offlineState.isCheckedOut
                            ? "check_in".tr()
                            : "check_out".tr(),
                        style: TextStyle(fontSize: 12.sp, height: 1.5.r),
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                'assets/home_bg/aziz_right_circle_arrow.png',
                height: 36,
                width: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

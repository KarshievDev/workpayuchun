import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance_method/view/attendane_method_screen.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../../../attendance/bloc/offline_attendance_bloc/offline_attendance_state.dart';
import '../../../../authentication/bloc/authentication_bloc.dart';

class CheckInOutCardMars extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const CheckInOutCardMars({
    super.key,
    required this.settings,
    required this.user,
    required this.dashboardModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfflineCubit, OfflineAttendanceState>(
      builder: (context, offlineState) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryBorderColor),
          ),
          child: InkWell(
            onTap: () {
              context.read<HomeBloc>().add(
                OnLocationRefresh(
                  user: context.read<AuthenticationBloc>().state.data?.user,
                ),
              );

              Navigator.push(
                context,
                AttendanceMethodScreen.route(
                  homeBloc: context.read<HomeBloc>(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
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
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offlineState.isCheckedIn == false
                              ? "start_time".tr()
                              : "done_for_today".tr(),
                          style: TextStyle(
                            fontSize: 16.r,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          offlineState.isCheckedIn == false
                              ? "check_in".tr()
                              : "check_out".tr(),
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 16.r,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

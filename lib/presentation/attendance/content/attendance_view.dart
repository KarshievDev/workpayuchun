import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance/content/shift_time_card.dart';
import 'package:strawberryhrm/presentation/attendance/content/location_header.dart';
import 'package:strawberryhrm/presentation/attendance/content/show_current_time.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/res/dialogs/custom_dialogs.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers/half_circular_shimmer.dart';
import 'animated_circular_button.dart';
import 'attendance_remarks_content.dart';

class AttendanceView extends StatefulWidget {
  final AttendanceType attendanceType;

  const AttendanceView({super.key, required this.attendanceType});

  @override
  State<AttendanceView> createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late HomeBlocFactory homeBloc;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      animationBehavior: AnimationBehavior.preserve,
    );
    homeBloc = instance<HomeBlocFactory>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final homeData = homeBloc().state.dashboardModel;
    final offlineAttendanceBloc = context.watch<OfflineCubit>();
    final offlineState = offlineAttendanceBloc.state;

    if (user?.user != null) {
      homeBloc().add(
        OnLocationRefresh(
          user: context.read<AuthenticationBloc>().state.data?.user,
        ),
      );
    }

    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.checkData?.message != null &&
            state.actionStatus == ActionStatus.checkInOut &&
            state.status != NetworkStatus.loading) {
          showLoginDialog(
            context: context,
            message: '${user?.user?.name}',
            body: '${state.checkData?.message}',
            isSuccess: state.checkData?.checkInOut != null ? true : false,
          );
        }
        if (state.actionStatus == ActionStatus.checkInOut &&
            state.status == NetworkStatus.success) {
          NavUtil.navigateScreen(
            context,
            BlocProvider.value(
              value: context.read<AttendanceBloc>(),
              child: AttendanceRemarksContent(
                attendanceId: state.checkData?.checkInOut?.id ?? 0,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                ),
              ),

              /// Show Current Location and Remote mode ......
              if (homeData != null) LocationHeader(homeData: homeData),
              SizedBox(height: 16.0),

              /// Show Check In Check Out time
              ShiftTimeCard(),

              /// Show Current time .......
              if (homeData != null) ShowCurrentTime(homeData: homeData),
              SizedBox(height: 16.0),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            return state.status == NetworkStatus.loading
                ? const HalfCircleShimmerButton()
                : AnimatedHalfCircularButton(
                  onComplete: () {
                    context.read<AttendanceBloc>().add(OnAttendance());
                  },
                  isCheckedIn: offlineState.isCheckedIn,
                  title:
                      offlineState.isCheckedIn == false
                          ? 'check_in'.tr()
                          : 'check_out'.tr(),
                  color:
                      offlineState.isCheckedIn == false
                          ? Branding.colors.primaryLight
                          : colorDeepRed,
                );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

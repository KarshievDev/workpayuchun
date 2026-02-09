import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ShowCurrentLocation extends StatelessWidget {
  final DashboardModel homeData;

  const ShowCurrentLocation({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    final attendanceBloc = context.watch<AttendanceBloc>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                attendanceBloc.state.location ?? '',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12.r, color: const Color(0xFF404A58)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 5.w),
              InkWell(
                onTap: () async {
                  if (context.read<AttendanceBloc>().state.locationLoaded) {
                    context.read<AttendanceBloc>().add(OnLocationRefreshEvent());
                  }
                },
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: colorPrimary,
                  child: Center(
                    child:
                    context.read<AttendanceBloc>().state.locationLoaded
                        ? Lottie.asset('assets/images/Refresh.json', height: 24.h, width: 24.w)
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerRight,
          child: FutureBuilder<int?>(
            future: SharedUtil.getRemoteModeType(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ToggleSwitch(
                  cornerRadius: 8.0,
                  activeBgColors: [
                    [Branding.colors.primaryDark,],
                    [Branding.colors.primaryDark,],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Branding.colors.primaryDark,
                  initialLabelIndex: snapshot.data,
                  totalSwitches: 2,
                  labels: ['home'.tr(), 'office'.tr()],
                  radiusStyle: true,
                  onToggle: (index) {
                    /// RemoteModeType
                    /// 0 ==> Home
                    /// 1 ==> office
                    context.read<AttendanceBloc>().add(OnRemoteModeChanged(mode: index ?? 0));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

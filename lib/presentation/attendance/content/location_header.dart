import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';

class LocationHeader extends StatefulWidget {
  final DashboardModel homeData;

  const LocationHeader({super.key, required this.homeData});

  @override
  State<LocationHeader> createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader> {
  int _remoteMode = 0;

  @override
  void initState() {
    super.initState();
    SharedUtil.getRemoteModeType().then((value) {
      setState(() => _remoteMode = value ?? 0);
    });
  }

  void _updateMode(int index) {
    setState(() => _remoteMode = index);
    context.read<AttendanceBloc>().add(OnRemoteModeChanged(mode: index));
  }

  @override
  Widget build(BuildContext context) {
    final attendanceBloc = context.watch<AttendanceBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Branding.colors.cardBackgroundDefault,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 6.r,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.locationDot,
                size: 16.sp,
                color: Branding.colors.iconInverse,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  attendanceBloc.state.location ?? '',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: Branding.colors.textInversePrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () async {
                  if (attendanceBloc.state.locationLoaded) {
                    context.read<AttendanceBloc>().add(
                      OnLocationRefreshEvent(),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: Branding.colors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child:
                      attendanceBloc.state.locationLoaded
                          ? Lottie.asset(
                            'assets/images/Refresh.json',
                            height: 20.h,
                            width: 20.w,
                          )
                          : SizedBox(
                            height: 16.r,
                            width: 16.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0.w),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Branding.colors.primaryLight),
            ),
            child: ToggleButtons(
              isSelected: [_remoteMode == 0, _remoteMode == 1],
              borderRadius: BorderRadius.circular(12.r),
              fillColor: Branding.colors.primaryLight,
              selectedColor: Colors.white,
              color: Branding.colors.textPrimary,
              constraints: BoxConstraints(minHeight: 32.h, minWidth: 70.w),
              onPressed: _updateMode,
              children: [
                Text('home'.tr(), style: GoogleFonts.nunito()),
                Text('office'.tr(), style: GoogleFonts.nunito()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

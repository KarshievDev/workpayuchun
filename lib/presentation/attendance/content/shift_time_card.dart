import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_state.dart';

class ShiftTimeCard extends StatelessWidget {
  const ShiftTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfflineCubit, OfflineAttendanceState>(
      builder: (context, offlineState) {
        final body = offlineState.attendanceBody;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Branding.colors.cardBackgroundDefault,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 3),
                blurRadius: 8.r,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTimeTile(
                        icon: Icons.schedule,
                        label: 'Start Time',
                        value: body?.inTime ?? '--:--',
                      ),
                    ),
                    Container(width: 1.w, height: 40.h, color: Branding.colors.dividerPrimary),
                    Expanded(
                      child: _buildTimeTile(
                        icon: Icons.hourglass_bottom,
                        label: 'End Time',
                        value: body?.outTime ?? '--:--',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Branding.colors.cardBackgroundSubdued,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                ),
                child: Center(
                  child: Text(
                    'Working time of recent shift ${timeDifference(time1: body?.inTime, time2: body?.outTime) ?? "--:--"} hours',
                    style: GoogleFonts.nunito(
                      fontSize: 12.sp,
                      color: Branding.colors.textInversePrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeTile({required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16.sp, color: Branding.colors.iconInverse),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.nunito(
                color: Branding.colors.textInversePrimary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.nunito(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Branding.colors.textInversePrimary,
          ),
        ),
      ],
    );
  }
}

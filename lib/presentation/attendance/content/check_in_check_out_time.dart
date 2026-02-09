import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_state.dart';

class CheckInCheckOutTime extends StatelessWidget {
  

  const CheckInCheckOutTime({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OfflineCubit,OfflineAttendanceState>(
      builder: (context,offlineState){
        
        final body = offlineState.attendanceBody;
        
        return BlocBuilder<AttendanceBloc,AttendanceState>(
          builder: (context,state){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Branding.colors.primaryLight,
                      size: 22.r,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      body?.inTime ?? "--:--",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "check_in".tr(),
                      style: TextStyle(fontSize: 12.r, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Branding.colors.primaryLight,
                      size: 22.r,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      body?.outTime ?? "--:--",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "check_out".tr(),
                      style: TextStyle(fontSize: 12.r, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.history,
                      color: Branding.colors.primaryLight,
                      size: 22.r,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      timeDifference(time1: body?.inTime, time2: body?.outTime) ?? "--:--",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "working_hr".tr(),
                      style: TextStyle(fontSize: 12.r, color: Colors.grey),
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

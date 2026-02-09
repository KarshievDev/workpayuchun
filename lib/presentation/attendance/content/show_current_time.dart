import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/digital_clock/src/digital_clock.dart';

class ShowCurrentTime extends StatelessWidget {
  final DashboardModel homeData;

  const ShowCurrentTime({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    ui.TextDirection direction = ui.TextDirection.ltr;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, size: 20.sp, color: const Color(0xFF404A58)),
          SizedBox(width: 4.w),
          Text(
            DateFormat('yMMMEd', 'en').format(DateTime.now()),
            style: GoogleFonts.nunitoSans(fontSize: 16.sp, color: const Color(0xFF404A58)),
          ),
          const SizedBox(width: 8),
          Directionality(
            textDirection: direction,
            child: DigitalClock(
              digitAnimationStyle: Curves.decelerate,
              is24HourTimeFormat: false,
              areaDecoration: const BoxDecoration(color: Colors.transparent),
              hourMinuteDigitTextStyle: TextStyle(
                color: const Color(0xFF404A58),
                fontSize: 32.sp,
              ),
              amPmDigitTextStyle: const TextStyle(color: Color(0xFF404A58), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

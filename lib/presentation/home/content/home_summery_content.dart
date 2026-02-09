import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_current_month_summery.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_today_summery.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/upcoming_event_pluto.dart';

class HomeSummeryContent extends StatelessWidget {
  const HomeSummeryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlutoCurrentMonthSummeryContent(),
        PlutoTodaySummeryContent(),
        SizedBox(height: 8.0.h),
        const PlutoUpcomingEvent(),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/today_summery_list_neptune.dart';

class NeptuneSummary extends StatelessWidget {
  const NeptuneSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'today_summary'.tr(),
            style: TextStyle(
                fontSize: 16.r, fontWeight: FontWeight.w500, height: 1.5, color: Colors.white, letterSpacing: 0.5),
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        const TodaySummeryListNeptune()
      ],
    );
  }
}

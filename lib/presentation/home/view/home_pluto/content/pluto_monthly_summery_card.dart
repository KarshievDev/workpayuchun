import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class PlutoMonthlyEventCard extends StatelessWidget {
  const PlutoMonthlyEventCard({super.key, required this.data, this.days = false, this.onPressed, this.pieChartWidget});

  final CurrentMonthData? data;
  final bool? days;
  final Function()? onPressed;
  final Widget? pieChartWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('${data?.image}', height: 20.h, color: Branding.colors.primaryLight),
            SizedBox(width: 16.0),
            Text(
              data?.title ?? '',
              maxLines: 1,
              style: TextStyle(
                color: Branding.colors.primaryLight,
                fontSize: 14.r,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            Spacer(),
            if (pieChartWidget != null) ...[pieChartWidget!, SizedBox(width: 16.0)],
            SizedBox(
              width: 50.0,
              child: Text(
                '${data?.number}',
                style: TextStyle(
                  color: Branding.colors.primaryDark,
                  fontSize: 20.r,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/date_utils.dart';

class BreakHeader extends StatelessWidget {
  final CustomTimerController timerController;
  final DashboardModel? dashboardModel;

  const BreakHeader(
      {super.key, required this.timerController, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: dashboardModel?.data?.breakHistory?.hasBreak == true,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'You_have_already_taken'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.r,
                          color: const Color(0xFF555555))),
                  TextSpan(
                      text: "${dashboardModel?.data?.breakHistory?.time ?? 0} ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.r,
                          color: Colors.redAccent)),
                  TextSpan(
                      text: 'break'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.r,
                          color: const Color(0xFF555555))),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: dashboardModel?.data?.breakHistory?.hasBreak == false,
          child: Text(
            "you_have_not_taken_a_break",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.r,
                color: const Color(0xFF555555)),
          ).tr(),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const HRMTimer(),
      ],
    );
  }
}

class HRMTimer extends StatefulWidget {
  const HRMTimer({super.key});

  @override
  State<HRMTimer> createState() => _HRMTimerState();
}

class _HRMTimerState extends State<HRMTimer> {
  String timer = '00:00:00';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      getSyncDuration().then((duration) {
        if (duration != null) {
          final t = duration.toString().split('.');
          t.removeLast();
          timer = duration.inHours < 10 ? '0${t.join(':')}' : t.join(':');
          if (mounted) {
            setState(() {});
          }
        } else {
          timer = '00:00:00';
          if (mounted) {
            setState(() {});
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(timer,
        style: GoogleFonts.cambay(
          fontSize: 40.0.r,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ));
  }
}

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/break/break_route.dart';
import 'package:user_repository/user_repository.dart';

class BreakCardMars extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const BreakCardMars({super.key, required this.settings, required this.user, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryBorderColor),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 18.0),
      child: InkWell(
        onTap: () {
          BreakRoute.breakOrQrCompanyRoute(context: context, inBreak: globalState.get(isBreak) == true);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.h),
          child: Row(
            children: [
              Expanded(child: Lottie.asset('assets/images/tea_time.json', height: 55.0.h, width: 55.0.w)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      globalState.get(isBreak) == true ? "you're_in_break".tr() : "take_coffee".tr(),
                      style: TextStyle(fontSize: 16.r, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0.5),
                    ),
                    // SizedBox(height: 10.h),
                    Text(
                      globalState.get(isBreak) == true
                          ? '${dashboardModel?.data?.config?.breakStatus?.breakTime}'
                          : 'break'.tr(),
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 16.r,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

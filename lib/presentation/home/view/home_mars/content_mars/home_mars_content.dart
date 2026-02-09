import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/natification/all_notification.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/home/view/home_mars/content_mars/break_card_mars.dart';
import 'package:strawberryhrm/presentation/home/view/home_mars/content_mars/checkin_out_card_mars.dart';
import 'package:strawberryhrm/presentation/home/view/home_mars/content_mars/current_month_mars.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/profile_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'home_bottom_mars.dart';
import 'mars_today_summary_list.dart';

class HomeMarsContent extends StatelessWidget {
  const HomeMarsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        final settings = context.read<HomeBloc>().state.settings;
        final user = context.read<AuthenticationBloc>().state.data;
        final homeData = context.read<HomeBloc>().state.dashboardModel;

        if (user?.user != null) {
          context.read<HomeBloc>().add(OnLocationEnabled(user: user!.user!));
        }

        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  ///blue background
                  Positioned(
                    right: 0,
                    left: 0,
                    child: Image.asset('assets/images/ic_banner_mars.png', fit: BoxFit.cover),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80.h),

                      ///Today Summary List ==========================
                      const TodaySummaryListMars(),
                      SizedBox(height: 18.h),

                      ///check-in-out card
                      CheckInOutCardMars(settings: settings, user: user, dashboardModel: homeData),

                      ///breakTime
                      BreakCardMars(settings: settings, user: user, dashboardModel: homeData),

                      ///bottom-header
                      HomeBottomMars(settings: settings, user: user, dashboardModel: homeData),

                      /// Current Month
                      const CurrentMonthMars(),

                      ///upcoming events:----------------------
                      SizedBox(height: 80.h),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 30,
                    child: SizedBox(width: 40, height: 40, child: Image.asset("assets/images/ic_logo.png")),
                  ),
                  Positioned(
                    right: 20,
                    top: 30,
                    child: InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(context, const NotificationScreen());
                      },
                      child: Image.asset("assets/images/ic_notification.png", height: 40, fit: BoxFit.fitHeight),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    top: 26,
                    child: ClipOval(
                      child: InkWell(
                        onTap: () {
                          NavUtil.navigateScreen(context, const ProfileScreen());
                        },
                        child: CachedNetworkImage(
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                          imageUrl: "${user?.user?.avatar}",
                          placeholder:
                              (context, url) => Center(child: Image.asset("assets/home_bg/placeholder_image.png")),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

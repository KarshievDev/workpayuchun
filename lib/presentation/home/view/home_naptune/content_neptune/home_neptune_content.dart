import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/view/content/home_content_shimmer.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/break_card_neptune.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/check_in_out_card_neptune.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/home_bottom_neptune.dart';
import 'package:strawberryhrm/presentation/home/view/home_naptune/content_neptune/neptune_summary.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import '../../../bloc/bloc.dart';
import '../../home_mars/content_mars/content_mars.dart';
import 'header_neptune.dart';

class HomeNeptuneContent extends StatelessWidget {
  const HomeNeptuneContent({super.key});

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

        return homeData != null
            ? BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      ///blue background
                      Positioned(
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/home_bg/home_bg_neptune.png',
                          fit: BoxFit.cover,
                          color: Branding.colors.primaryLight,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// header
                          Container(
                            padding: const EdgeInsets.only(top: 0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /// Neptune Header
                                          HeaderNeptune(),
                                          NeptuneSummary(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          ///check-in-out card
                          CheckInOutCardNeptune(settings: settings, user: user, dashboardModel: homeData),

                          ///breakTime
                          BreakCardNeptune(settings: settings, user: user, dashboardModel: homeData),

                          ///bottom-header
                          HomeBottomNeptune(settings: settings, user: user, dashboardModel: homeData),

                          /// Current Month
                          const CurrentMonthMars(),
                          SizedBox(height: 80.h),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
            : const HomeContentShimmer();
      },
    );
  }
}

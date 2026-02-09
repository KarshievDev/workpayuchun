import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart' show HomeBloc, HomeState, OnLocationEnabled;
import 'package:strawberryhrm/presentation/home/content/break_card.dart';
import 'package:strawberryhrm/presentation/home/content/checkin_out_card.dart';
import 'package:strawberryhrm/presentation/home/content/home_header.dart';
import 'package:strawberryhrm/presentation/home/content/home_summery_content.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';

class HomeEarthContent extends StatelessWidget {
  const HomeEarthContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        final user = context.read<AuthenticationBloc>().state.data;

        if (user?.user != null) {
          context.read<HomeBloc>().add(OnLocationEnabled(user: user!.user!));
        }

        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return ListView(
              children: [
                ///top-header
                HomeHeader(settings: homeState.settings, user: user, dashboardModel: homeState.dashboardModel),

                ///check-in-out card
                CheckInOutCard(settings: homeState.settings, user: user, dashboardModel: homeState.dashboardModel),

                ///breakTime
                BreakCard(settings: homeState.settings, user: user, dashboardModel: homeState.dashboardModel),

                ///bottom-header
                HomeSummeryContent(),
              ],
            );
          },
        );
      },
    );
  }
}

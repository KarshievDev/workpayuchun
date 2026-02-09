import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/home/content/home_summery_content.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_check_break_content.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_home_header.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';

class HomePlutoContent extends StatelessWidget {
  const HomePlutoContent({super.key});

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
                PlutoHomeHeader(settings: homeState.settings, user: user, dashboardModel: homeState.dashboardModel),

                ///check-in-out-creak content
                PlutoCheckBreakContent(
                  settings: homeState.settings,
                  user: user,
                  dashboardModel: homeState.dashboardModel,
                ),

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_break_card.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_checkin_out_card.dart';
import 'package:user_repository/user_repository.dart';

class PlutoCheckBreakContent extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const PlutoCheckBreakContent({
    super.key,
    required this.user,
    required this.dashboardModel,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 360;
          final cardWidth = isWide
              ? (constraints.maxWidth - 8.0) / 2
              : constraints.maxWidth;
          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              SizedBox(
                width: cardWidth,
                child: PlutoCheckInOutCard(
                  settings: settings,
                  user: user,
                  dashboardModel: dashboardModel,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: PlutoBreakCard(
                  settings: settings,
                  user: user,
                  dashboardModel: dashboardModel,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

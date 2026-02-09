import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import '../../../content/event_card.dart';

class HomeBottomNeptune extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeBottomNeptune(
      {super.key,
      required this.settings,
      required this.user,
      required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpcomingEventCardNeptune(
          events: dashboardModel?.data?.upcomingEvents ?? [],
        ),
        SizedBox(height: 12.0.h),
      ],
    );
  }
}

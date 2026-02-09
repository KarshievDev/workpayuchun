import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import 'package:core/core.dart';

class PlutoHomeHeader extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const PlutoHomeHeader({super.key, required this.settings, required this.user, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Branding.colors.primaryDark,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0),bottomRight: Radius.circular(16.0))
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 24.r, color: Colors.white, fontWeight: FontWeight.bold)),
          )
      ),
    );
  }
}

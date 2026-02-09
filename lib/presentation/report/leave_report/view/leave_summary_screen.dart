import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/report/leave_report/leave_report.dart';

class LeaveSummeryScreen extends StatelessWidget {
  const LeaveSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (BuildContext context) => LeaveReportBloc(
          userId: user!.user!.id!,
          metaClubApiClient: MetaClubApiClient(
              httpService: instance()))
        ..add(GetLeaveReportSummary()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
            iconTheme: IconThemeData(
                size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
            title: Text(
              tr('leave_summery'),
              style: TextStyle(fontSize: 16.r),
            ),
          ),
        ),
        body: const LeaveReportSummaryContent(),
      ),
    );
  }
}

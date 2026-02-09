import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import '../../../bloc/report_bloc.dart';
import 'attendance_summary_body.dart';

class AttendanceSummaryContent extends StatelessWidget {
  const AttendanceSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (BuildContext context) => ReportBloc(
            metaClubApiClient: MetaClubApiClient(httpService: instance()),
            userId: user!.user!.id!)
          ..add(GetReportData()),
        child: const AttendanceSummaryBody());
  }
}

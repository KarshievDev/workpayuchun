import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/res/shimmers.dart';

import '../../../../bloc/report_bloc.dart';
import 'summary_of_daily_report_list_tile.dart';

class DailyReportTile extends StatelessWidget {
  const DailyReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    final reportBloc = context.watch<ReportBloc>();

    return reportBloc.state.attendanceReport?.reportData?.dailyReport != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reportBloc.state.attendanceReport?.reportData?.dailyReport?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final data = reportBloc.state.attendanceReport?.reportData?.dailyReport?[index];
              return SummaryOfDailyReportListTile(
                dailyReport: data!,
                isReportSummary: true,
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TileShimmer(
                  titleHeight: 30,
                  isSubTitle: true,
                ),
              );
            },
          );
  }
}

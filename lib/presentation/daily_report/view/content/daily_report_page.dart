import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/view/daily_report_list.dart';

class DailyReportPage extends StatelessWidget {
  const DailyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyReportBloc = instance.get<DailyReportBlocFactory>();

    return BlocProvider(
      create: (context) => dailyReportBloc(),
      child: const DailyReportListScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';

class TotalSalesTodayWidget extends StatelessWidget {
  const TotalSalesTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWithValidation(
      validator: (val) => val?.isEmpty == true ? "*Required field" : null,
      title: "Total Sales Today *",
      hints: "In Kgs",
      controller: context.read<DailyReportBloc>().totalSalesController,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';

class DailyReportSummaryWidget extends StatelessWidget {
  const DailyReportSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWithValidation(
      validator: (val) {
        if (val?.isEmpty == true) {
          return "*Required field";
        } else if (val != null && val.length < 10) {
          return "Report summary must be at least 10 characters.";
        } else {
          return null;
        }
      },
      maxLine: 5,
      title: "Daily Report Summary *",
      hints: "Write a general summary of your work activity today.",
      controller: context.read<DailyReportBloc>().dailyReportSummaryController,
    );
  }
}

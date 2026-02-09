import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';

class PositiveLeadsTodayWidget extends StatelessWidget {
  const PositiveLeadsTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
          textInputType: TextInputType.number,
          title: "Positive Leads Today *",
          hints: "Enter Positive Leads Today",
          controller: context.read<DailyReportBloc>().positiveLeadsController,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

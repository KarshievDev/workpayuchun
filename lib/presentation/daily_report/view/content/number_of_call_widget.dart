import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';

class NumberOfCallWidget extends StatelessWidget {
  const NumberOfCallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
          textInputType: TextInputType.number,
          title: "Number Of Calls You Did Today? *",
          hints: "Enter Call That You Have Done Today",
          controller: context.read<DailyReportBloc>().callsMadeController,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

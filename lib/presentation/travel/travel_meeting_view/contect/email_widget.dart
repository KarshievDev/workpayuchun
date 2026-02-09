import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          title: "E-mail *",
          hints: "ex_email_example".tr(),
          textInputType: TextInputType.emailAddress,
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
          controller: context.read<TravelMeetingBloc>().emailController,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

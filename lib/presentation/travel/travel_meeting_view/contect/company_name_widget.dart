import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class CompanyNameWidget extends StatelessWidget {
  const CompanyNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          title: "Customer Company Name *",
          hints: "Customer Company Name",
          textInputType: TextInputType.text,
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
          controller: context.read<TravelMeetingBloc>().companyNameController,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

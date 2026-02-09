import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          hints: "Phone Number ",
          title: 'Phone Number *',
          controller: context.read<TravelMeetingBloc>().phoneNumberController,
          textInputType: TextInputType.phone,
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

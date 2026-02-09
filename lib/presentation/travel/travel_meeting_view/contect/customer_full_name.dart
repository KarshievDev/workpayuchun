import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_validation.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class CustomerFullName extends StatelessWidget {
  const CustomerFullName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithValidation(
          title: "Customer Full Name *",
          value: '',
          hints: "Enter Full Name",
          textInputType: TextInputType.name,
          validator: (val) => val?.isEmpty == true ? "*Required field" : null,
          controller: context.read<TravelMeetingBloc>().nameController,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

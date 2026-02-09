import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class PurposeOfTravelWidget extends StatelessWidget {
  const PurposeOfTravelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hints: "Description of meeting",
          title: 'Purpose of Travel *',
          maxLine: 4,
          controller: context.read<TravelMeetingBloc>().purposeOfTravelController,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

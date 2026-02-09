import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class RemarkWidget extends StatelessWidget {
  const RemarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: "Remark ",
      hints: "Remark",
      controller: context.read<TravelMeetingBloc>().remarkController,
    );
  }
}

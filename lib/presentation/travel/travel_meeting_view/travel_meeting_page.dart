import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_meeting_view/travel_meeting_list.dart';

class TravelMeetingPage extends StatelessWidget {
  final TravelPlanItem travelPlan;

  const TravelMeetingPage({super.key, required this.travelPlan});

  @override
  Widget build(BuildContext context) {
    final travelMeetingBloc = instance.get<TravelMeetingBlocFactory>();
    return BlocProvider(
      create: (context) => travelMeetingBloc(travelPlanItem: travelPlan),
      child: const TravelMeetingListScreen(),
    );
  }
}

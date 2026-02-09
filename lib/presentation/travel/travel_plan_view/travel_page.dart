import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_bloc/travel_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/travel_plan_list.dart';

class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final travelBloc = instance.get<TravelBlocFactory>();

    return BlocProvider(
      create: (context) => travelBloc(),
      child: const TravelPlanListScreen(),
    );
  }
}

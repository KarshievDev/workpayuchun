import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_bloc/travel_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/travel_plan_create.dart';
import 'content/floating_button.dart';
import 'content/travel_item_card.dart';

class TravelPlanListScreen extends StatelessWidget {
  const TravelPlanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider.value(value: context.read<TravelBloc>(), child: const TravelPlanCreate()),
                ),
              );
            },
          ),
          appBar: AppBar(title: const Text("Travel Plan List", style: TextStyle(color: Colors.white))),
          body: BlocBuilder<TravelBloc, TravelState>(
            builder: (context, state) {
              if (state.status == NetworkStatus.loading) {
                return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: GeneralListShimmer());
              } else if (state.status == NetworkStatus.success) {
                List<TravelPlanItem>? travelPlanList = state.travelPlanModel?.data?.data;
                return TravelItemCard(travelPlanList: travelPlanList);
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}

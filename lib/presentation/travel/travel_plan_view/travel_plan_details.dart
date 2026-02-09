import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_expense_bloc/travel_expense_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_expense_view/travel_expense_screen.dart';
import 'package:strawberryhrm/presentation/travel/travel_meeting_view/travel_meeting_page.dart';

import 'content/travel_details_content.dart';

class TravelPlanDetailsScreen extends StatelessWidget {
  final TravelPlanItem travelPlan;
  const TravelPlanDetailsScreen({super.key,required this.travelPlan});

  @override
  Widget build(BuildContext context) {
    final travelExpenseBloc = instance<TravelExpenseBlocFactory>();
    return BlocProvider(
      create: (context)=> travelExpenseBloc(travelPlanItem: travelPlan),
      lazy: false,
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Travel Plan Details",style: TextStyle(color: Colors.white),),
            bottom:
             TabBar(
                tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(overflow: TextOverflow.ellipsis, "Details", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(overflow: TextOverflow.ellipsis, "Travel Meeting", style:  TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(overflow: TextOverflow.ellipsis, "Travel Expense", style:  TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
               indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(color: Branding.colors.primaryDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
            ),
          ),
          body: TabBarView(
              children: [
                TravelDetailsContent(travelPlan: travelPlan,),
                TravelMeetingPage(travelPlan: travelPlan,),
                const TravelExpenseScreen()
              ])


        ),
      ),
    );
  }
}



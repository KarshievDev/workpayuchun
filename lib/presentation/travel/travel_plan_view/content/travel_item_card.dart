import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/travel_plan_details.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/travel_plan_list_card.dart';

class TravelItemCard extends StatelessWidget {
  final List<TravelPlanItem>? travelPlanList;

  const TravelItemCard({super.key, this.travelPlanList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColorGray,
      child:
          travelPlanList?.isNotEmpty == true
              ? ListView.separated(
                itemCount: travelPlanList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  TravelPlanItem? travelPlan = travelPlanList?[index];
                  return TravelPlanListCard(
                    image: travelPlan?.employee?.avatar,
                    startLocation: travelPlan?.fromLocation,
                    endLocation: travelPlan?.toLocation,
                    startDate: travelPlan?.fromDate,
                    endDate: travelPlan?.toDate,
                    onTap: () => NavUtil.navigateScreen(context, TravelPlanDetailsScreen(travelPlan: travelPlan!)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 5);
                },
              )
              : const NoDataFoundWidget(),
    );
  }
}

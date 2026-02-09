import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_expense_bloc/travel_expense_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_expense_view/create_travel_expense.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/content/floating_button.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class TravelExpenseScreen extends StatelessWidget {
  const TravelExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelExpenseBloc, TravelExpenseState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading || state.status == NetworkStatus.initial) {
          return const GeneralListShimmer();
        }

        if (state.status == NetworkStatus.failure) {
          return const NoDataFoundWidget();
        }

        final expenses = state.travelExpense?.data?.expenses ?? [];

        return Scaffold(
          floatingActionButton: FloatingButton(
            onTap: () => NavUtil.navigateScreen(
                context, SubmitTravelExpenseScreen(travelExpenseBloc: context.read<TravelExpenseBloc>())),
          ),
          body: Container(
            color: bgColor,
            child: expenses.isNotEmpty ?  ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = expenses[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Date",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Mode Of Transportation",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Total Amount",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Approved Amount",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Status",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "Rating",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        ": ${item.date}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        ": ${item.modeOfTransportation}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        ": \$ ${item.totalAmount}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        ": \$ ${item.approvalAmount}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Branding.colors.primaryDark,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        ": ${item.status}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: item.rating != null ? double.parse(item.rating.toString()): 0.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 15,
                                        tapOnlyMode: true,
                                        ignoreGestures: true,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          context.read<TravelExpenseBloc>().add(OnReviewChanged(rating: rating.ceil()));
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                }) : const NoDataFoundWidget(),
          ),
        );
      },
    );
  }
}

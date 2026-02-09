import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:core/core.dart';

class CurrentMonthMars extends StatelessWidget {
  const CurrentMonthMars({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.watch<HomeBloc>().state.dashboardModel;
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 18),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: primaryBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'current_month',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).tr(),
           Text(
            'an_overview_of_your_progress'.tr(),
            style: const TextStyle(fontSize: 12),
          ).tr(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            color: primaryBorderColor,
            height: 0.5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  dashboardModel?.data?.currentMonth?.length ?? 0, (index) {
                final currentMonth = dashboardModel?.data?.currentMonth?[index];
                return Container(
                  margin: const EdgeInsets.only(right: 18.0),
                  child: Column(
                    children: [
                      Text(
                        "${currentMonth?.number ?? 0}",
                        style: const TextStyle(
                            color: Color(0xffF76B6E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${currentMonth?.title ?? 0}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ).tr()
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/home/router/home__menu_router.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_todays_summery_card.dart';

class PlutoTodaySummeryContent extends StatelessWidget {

  const PlutoTodaySummeryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<HomeBloc>().state.settings;
    final todayData = context.read<HomeBloc>().state.dashboardModel?.data?.today ?? [];

    Widget pieChart({required int currentIndex}) {
      List<PieChartSectionData> sections = [];

      for (int i = 0; i < todayData.length; i++) {
        sections.add(
          PieChartSectionData(
            color: i == currentIndex ? Colors.white : Branding.colors.primaryDark,
            value: double.tryParse(todayData[i].number.toString()),
            radius: 20.0,
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
            showTitle: false,
          ),
        );
      }

      return SizedBox.square(
        dimension: 45.0,
        child: PieChart(
          PieChartData(centerSpaceRadius: 0, sectionsSpace: 0, startDegreeOffset: 270, sections: sections),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Today\'s Summery',
            style: TextStyle(
              fontSize: 16.r,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: 8.0.h),
        Column(
          children: List.generate(
            todayData.length,
            (index) => PlutoTodayEventCard(
              data: todayData[index],
              pieChartWidget: pieChart(currentIndex: index),
              onPressed: () => currentMonthRouteSlug(todayData[index].slug, context, settings),
            ),
          ),
        ),
      ],
    );
  }
}

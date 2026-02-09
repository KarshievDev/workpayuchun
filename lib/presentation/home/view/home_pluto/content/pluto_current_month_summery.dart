import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/home/router/home__menu_router.dart';
import 'package:strawberryhrm/presentation/home/view/home_pluto/content/pluto_monthly_summery_card.dart';

class PlutoCurrentMonthSummeryContent extends StatelessWidget {

  const PlutoCurrentMonthSummeryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<HomeBloc>().state.settings;
    final monthsData = context.read<HomeBloc>().state.dashboardModel?.data?.currentMonth ?? [];

    Widget pieChart({required int currentIndex}) {
      List<PieChartSectionData> sections = [];

      for (int i = 0; i < monthsData.length; i++) {
        sections.add(
          PieChartSectionData(
            color: i == currentIndex ? Colors.white : Branding.colors.primaryDark,
            value: double.tryParse(monthsData[i].number.toString()),
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
            'current_month_summary'.tr(),
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
            monthsData.length,
            (index) => PlutoMonthlyEventCard(
              data: monthsData[index],
              pieChartWidget: pieChart(currentIndex: index),
              onPressed: () => currentMonthRouteSlug(monthsData[index].slug, context, settings),
            ),
          ),
        ),
      ],
    );
  }
}

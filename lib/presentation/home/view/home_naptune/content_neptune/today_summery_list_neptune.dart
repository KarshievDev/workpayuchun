import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/home/router/home__menu_router.dart';
import 'package:core/core.dart';
import '../../../bloc/bloc.dart';

class TodaySummeryListNeptune extends StatelessWidget {
  const TodaySummeryListNeptune({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.read<HomeBloc>().state.dashboardModel;
    return SizedBox(
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: dashboardModel?.data?.today?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final data = dashboardModel?.data?.today?[index];
          return Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => routeSlug(data?.slug, context),
                  child: Column(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          height: 75,
                          width: 75,
                          child: Card(
                            child: Center(
                              child: Text(
                                data?.number.toString() ?? "00",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorPrimary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data?.title.toString() ?? "",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ).tr()
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

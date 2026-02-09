import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';

class PlutoUpcomingEvent extends StatelessWidget {
  const PlutoUpcomingEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.read<HomeBloc>().state.dashboardModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'public_holiday_and_even'.tr(),
                  style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          if (dashboardModel?.data?.upcomingEvents?.isNotEmpty == true)
            SizedBox(
              height: 210,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: dashboardModel?.data?.upcomingEvents?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final data = dashboardModel?.data?.upcomingEvents?[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 133,
                          width: 208,
                          fit: BoxFit.cover,
                          imageUrl: "${data?.image}",
                          placeholder: (context, url) => Center(child: Image.asset("assets/images/placeholder_image.png")),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        const SizedBox(height: 8),
                        Text("${data?.startDate}", style: const TextStyle(color: Color(0xff929292), fontSize: 12)),
                        const SizedBox(height: 8),
                        Text("${data?.title}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

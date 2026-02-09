import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:core/core.dart';

class UpcomingEventMars extends StatelessWidget {
  const UpcomingEventMars({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.read<HomeBloc>().state.dashboardModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "recent_events".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ).tr(),
              ],
            ),
          ),
          dashboardModel?.data?.upcomingEvents?.isNotEmpty == true
              ? SizedBox(
                  height: 230,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          dashboardModel?.data?.upcomingEvents?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            dashboardModel?.data?.upcomingEvents?[index];
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
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder_image.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("${data?.startDate}",
                                  style: const TextStyle(
                                      color: Color(0xff929292), fontSize: 12)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("${data?.title}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      }))
              : Container(
                  margin: const EdgeInsets.only(bottom: 18.0),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: primaryBorderColor)),
                  child: const Center(child: Text('no_recent_available'))),
        ],
      ),
    );
  }
}

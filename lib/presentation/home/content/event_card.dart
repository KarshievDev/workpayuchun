import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:core/core.dart';
import 'event_card_item.dart';

class EventCard extends StatelessWidget {

  const EventCard({super.key, required this.data, this.days = false, this.onPressed});

  final TodayData? data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  Image.network(
                    '${data?.image}',
                    height: 25.h,
                    color: Branding.colors.primaryLight,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        '${data?.number}',
                        style: TextStyle(
                            fontSize: 20.r,
                            color: Branding.colors.primaryLight,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                      if (days == true)
                        Text(
                          'days'.tr(),
                          style: TextStyle(
                              color: Branding.colors.primaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 4,
                              letterSpacing: 0.5),
                        ),
                    ],
                  ),
                  Text(
                    data?.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 12.r,
                        color: Branding.colors.primaryLight,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ).tr(),
                  SizedBox(
                    height: 6.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard2 extends StatelessWidget {
  const EventCard2(
      {super.key, required this.data, this.days = false, this.onPressed});

  final CurrentMonthData? data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  Image.network(
                    '${data?.image}',
                    height: 20.h,
                    color: mainColor,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        '${data?.number}',
                        style: TextStyle(
                            fontSize: 20.r,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                      if (days == true)
                        Text(
                          'days'.tr(),
                          style: TextStyle(
                              color: const Color(0xFF777777),
                              fontSize: 12.r,
                              fontWeight: FontWeight.w500,
                              height: 4,
                              letterSpacing: 0.5),
                        ),
                    ],
                  ),
                  Text(
                    data?.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 14.r,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ).tr(),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({super.key, required this.events});

  final List<UpcomingEvent> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/new_Upcoming_Event.png',
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('upcoming_events'.tr(),
                      style: TextStyle(
                          fontSize: 16.r,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('public_holiday_and_even'.tr(),
                      style: TextStyle(
                          fontSize: 12.r,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: const Color(0xFF555555),
                          letterSpacing: 0.5)),
                  SizedBox(
                    height: 6.h,
                  ),
                  Column(
                    children: events
                        .map((e) => EventCardItem(upcomingItems: e))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingEventCardMars extends StatelessWidget {
  const UpcomingEventCardMars({super.key, required this.events});

  final List<UpcomingEvent> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        // semanticContainer: true,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryBorderColor)),

        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/new_Upcoming_Event.png',
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('upcoming_events'.tr(),
                      style: TextStyle(
                          fontSize: 16.r,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('public_holiday_and_even'.tr(),
                      style: TextStyle(
                          fontSize: 12.r,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: const Color(0xFF555555),
                          letterSpacing: 0.5)),
                  SizedBox(
                    height: 6.h,
                  ),
                  Column(
                    children: events
                        .map((e) => EventCardItem(upcomingItems: e))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingEventCardNeptune extends StatelessWidget {
  const UpcomingEventCardNeptune({super.key, required this.events});

  final List<UpcomingEvent> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        // semanticContainer: true,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryBorderColor)),

        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/new_Upcoming_Event.png',
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('upcoming_events'.tr(),
                      style: TextStyle(
                          fontSize: 16.r,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('public_holiday_and_even'.tr(),
                      style: TextStyle(
                          fontSize: 12.r,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: const Color(0xFF555555),
                          letterSpacing: 0.5)),
                  SizedBox(
                    height: 6.h,
                  ),
                  Column(
                    children: events
                        .map((e) => EventCardItem(upcomingItems: e))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

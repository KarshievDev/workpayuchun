import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:core/core.dart';

class EventCardItem extends StatelessWidget {
  const EventCardItem(
      {super.key, required this.upcomingItems, this.viewAllPressed});

  final UpcomingEvent upcomingItems;

  final Function()? viewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
      )),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${upcomingItems.date}',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14.r,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.5)),
                  Text('${upcomingItems.day}',
                      style: TextStyle(
                          fontSize: 12.r,
                          color: const Color(0xFF555555),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          letterSpacing: 0.5)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: VerticalDivider(
                color: colorPrimary,
                thickness: 2,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${upcomingItems.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.r,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

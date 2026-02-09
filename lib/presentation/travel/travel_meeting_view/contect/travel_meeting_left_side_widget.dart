import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TravelMeetingLeftSideWidget extends StatelessWidget {
  const TravelMeetingLeftSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          "Company",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "Customer Name",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "Email",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "Phone",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "Schedule Time",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "Start Time",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          "End Time",
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
    );
  }
}

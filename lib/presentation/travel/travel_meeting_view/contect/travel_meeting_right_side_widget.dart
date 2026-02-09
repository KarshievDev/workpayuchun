import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meta_club_api/meta_club_api.dart';

class TravelMeetingRightWidget extends StatelessWidget {
  final MeetingData? meetingResponse;

  const TravelMeetingRightWidget({super.key, this.meetingResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.date ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.customerCompanyName ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.customerName ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.customerEmail ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.customerPhone ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.meetingScheduleTime ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.meetingStartTime ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ": ${meetingResponse?.meetingEndTime ?? "N/A"}",
          style: TextStyle(
            fontSize: 12,
            color: Branding.colors.primaryDark,
          ),
        ),
        RatingBar.builder(
          initialRating: meetingResponse?.rating?.toDouble() ?? 0.0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 15,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }
}

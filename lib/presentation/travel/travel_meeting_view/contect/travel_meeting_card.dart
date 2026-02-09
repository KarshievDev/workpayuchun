import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meta_club_api/meta_club_api.dart';

class TravelMeetingCard extends StatelessWidget {
  final MeetingData? meetingResponse;
  const TravelMeetingCard({super.key,this.meetingResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
      child: Card(
        color: Colors.white,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
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
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
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
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

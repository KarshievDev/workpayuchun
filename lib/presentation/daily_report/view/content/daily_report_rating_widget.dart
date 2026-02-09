import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';

class DailyReportRatingWidget extends StatelessWidget {
  const DailyReportRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "In Terms of Production, How was your day?",
          style: TextStyle(fontSize: 12.r, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemSize: 28,
          itemCount: 10,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(CupertinoIcons.star_fill, color: Colors.amber, size: 8,),
          onRatingUpdate: (rating) {
            context.read<DailyReportBloc>().add(OnReviewChangedEvent(rating: rating.ceil()));
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

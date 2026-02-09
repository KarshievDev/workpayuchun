import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          "Rate Your Meeting Experience *",
          style: TextStyle(fontSize: 12.r, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            context.read<TravelMeetingBloc>().add(OnReviewChanged(rating: rating.ceil()));
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

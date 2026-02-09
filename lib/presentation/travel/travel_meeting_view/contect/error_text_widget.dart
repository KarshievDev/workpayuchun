import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class ErrorTextWidget extends StatelessWidget {
  final TravelMeetingState? state;

  const ErrorTextWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: state?.errorMsg == null ? false : true,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5.0),
          child: Text(
            state?.errorMsg ?? "",
            style: TextStyle(fontSize: 12.r, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

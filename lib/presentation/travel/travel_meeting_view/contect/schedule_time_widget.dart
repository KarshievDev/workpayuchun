import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class ScheduleTimeWidget extends StatelessWidget {
  final TravelMeetingState? state;

  const ScheduleTimeWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Schedule Time *",
          style: TextStyle(fontSize: 12.r, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black12)),
          child: InkWell(
            onTap: () {
              context.read<TravelMeetingBloc>().add(OnSelectScheduleTime(context));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.scheduleTime ?? "Select Schedule Time", style: TextStyle(fontSize: 12.r)),
                  Icon(
                    CupertinoIcons.clock,
                    color: Colors.grey,
                    size: 18.r,
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
            visible: state?.scheduleTime == null ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0),
              child: Text(
                "Select Schedule time *",
                style: TextStyle(fontSize: 12.r, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

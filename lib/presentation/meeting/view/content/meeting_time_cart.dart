import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/meeting/bloc/meeting_bloc.dart';

import 'package:core/core.dart';

class MeetingTimeCart extends StatelessWidget {
  final MeetingState? meetingState;
  const MeetingTimeCart({super.key,this.meetingState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr("start_time"), style: TextStyle(fontSize: 14.r, color: Colors.black, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Card(color: colorCardBackground, elevation: 0.0,
                child: InkWell(
                  onTap: () {
                    context.read<MeetingBloc>().add(SelectStartTime(context));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16).r,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(meetingState?.startTime ?? tr("start_time"), style: TextStyle(fontSize: 12.r)),
                         Icon(Icons.arrow_drop_down_sharp, color: Colors.grey,size: 18.r,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr("end_time"),
                style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
              ),
              const SizedBox(height: 10),
              Card(
                color: colorCardBackground,
                elevation: 0.0,
                child: InkWell(
                  onTap: () {
                    context.read<MeetingBloc>().add(SelectEndTime(context));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(meetingState?.endTime ?? tr("end_time"),  style: TextStyle(fontSize: 12.r),),
                         Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18.r)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

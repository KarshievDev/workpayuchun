import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';

class DailyReportEndTimeWidget extends StatelessWidget {
  final DailyReportState? state;

  const DailyReportEndTimeWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "End Time*",
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
              context.read<DailyReportBloc>().add(OnSelectEndTimeEvent(context));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.endTime ?? "Select End Time", style: TextStyle(fontSize: 12.r)),
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
            visible: state?.endTime == null ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0),
              child: Text(
                "Select end time",
                style: TextStyle(fontSize: 12.r, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';

class DailyReportErrorTextWidget extends StatelessWidget {
  final DailyReportState? state;

  const DailyReportErrorTextWidget({super.key, this.state});

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
          )),
    );
  }
}

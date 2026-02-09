import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';

class SelectReportDateWidget extends StatelessWidget {
  final DailyReportState? state;

  const SelectReportDateWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Date of Report*',
          style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        CustomDatePicker(
          label: state?.reportDate ?? "Select Report Date",
          onDatePicked: (DateTime date) {
            context
                .read<DailyReportBloc>()
                .add(OnSelectReportDateEvent(reportDate: DateFormat('yyyy-MM-dd').format(date)));
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

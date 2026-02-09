import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_radio_tile.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';

class RecoveryTodayWidget extends StatelessWidget {
  final DailyReportState? state;

  const RecoveryTodayWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Did you worked on recovery today?*",
          style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomRadioTile(
                onChanged: (val) {
                  context.read<DailyReportBloc>().add(OnWorkRecoveryEvent(recovery: val));
                },
                title: 'Yes',
                initialData: state?.workedRecoveryValue,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (val) {
                  context.read<DailyReportBloc>().add(OnWorkRecoveryEvent(recovery: val));
                },
                title: 'No',
                initialData: state?.workedRecoveryValue,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (val) {
                  context.read<DailyReportBloc>().add(OnWorkRecoveryEvent(recovery: val));
                },
                title: 'Other',
                initialData: state?.workedRecoveryValue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: state?.workedRecoveryValue == "Other" ? 16 : 0,
        ),
        state?.workedRecoveryValue == "Other"
            ? CustomTextField(
                title: "Is worked on recovery Today",
                maxLine: 5,
                hints: "Write Is worked on recovery Today",
                controller: context.read<DailyReportBloc>().recoveryTodayOtherNoteController,
              )
            : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

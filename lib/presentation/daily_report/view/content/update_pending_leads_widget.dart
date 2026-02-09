import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_radio_tile.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';

class UpdatePendingLeadsWidget extends StatelessWidget {
  final DailyReportState? state;

  const UpdatePendingLeadsWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Did you update your pending and leads?*",
          style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomRadioTile(
                onChanged: (pendingLeadsData) {
                  context.read<DailyReportBloc>().add(OnPendingLeadsEvent(leads: pendingLeadsData));
                },
                title: 'Yes',
                initialData: state?.pendingLeadsValue,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (pendingLeadsData) {
                  context.read<DailyReportBloc>().add(OnPendingLeadsEvent(leads: pendingLeadsData));
                },
                title: 'No',
                initialData: state?.pendingLeadsValue,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (pendingLeadsData) {
                  context.read<DailyReportBloc>().add(OnPendingLeadsEvent(leads: pendingLeadsData));
                },
                title: 'Other',
                initialData: state?.pendingLeadsValue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: state?.pendingLeadsValue == "Other" ? 16.0 : 0.0,
        ),
        state?.pendingLeadsValue == "Other"
            ? CustomTextField(
                title: "Pending and leads other note *",
                maxLine: 5,
                hints: "Write Pending and Leads other note.",
                controller: context.read<DailyReportBloc>().pendingAndLeadsOtherNoteController,
              ) : const SizedBox(),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

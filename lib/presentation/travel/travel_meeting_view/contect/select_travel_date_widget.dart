import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';

class SelectTravelDateWidget extends StatelessWidget {
  final TravelMeetingState? state;
  const SelectTravelDateWidget({super.key,this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text('Date *',
          style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        CustomDatePicker(
          label: state?.travelDate ?? "Select Travel Date",
          onDatePicked: (DateTime date) {
            context.read<TravelMeetingBloc>().add(OnSelectTravelDate(travelDate: DateFormat('yyyy-MM-dd').format(date)));
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

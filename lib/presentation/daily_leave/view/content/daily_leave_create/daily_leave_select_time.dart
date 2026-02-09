import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';

class DailyLeaveSelectTime extends StatelessWidget {
  const DailyLeaveSelectTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 4.r),
        onTap: () {
          showTimePicker(context: context, initialTime: TimeOfDay.now())
              .then((value) {
            if (value != null && context.mounted) {
              var selectedTime = value.format(context);
              context
                  .read<DailyLeaveBloc>()
                  .add(SelectApproxTime(selectedTime));
            }
          });
        },
        leading: Icon(Icons.access_time_outlined, size: 20.r),
        title: Text(
            context.watch<DailyLeaveBloc>().state.approxTime ?? 'time'.tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.r)),
        trailing: Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 23.r,
        ),
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';

class PlutoDailyLeaveSelectTime extends StatelessWidget {
  const PlutoDailyLeaveSelectTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Branding.colors.primaryLight,)), margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 4.r),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.r),
        onTap: () {
          showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
            if (value != null && context.mounted) {
              var selectedTime = value.format(context);
              context.read<DailyLeaveBloc>().add(SelectApproxTime(selectedTime));
            }
          });
        },
        title: Text(context.watch<DailyLeaveBloc>().state.approxTime ?? 'time'.tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.r,color: Branding.colors.textPrimary)),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.access_time_outlined, size: 20.r,color: Branding.colors.primaryLight,),
        ),
      ),
    );
  }
}

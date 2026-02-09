import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_state.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_daily_leave_reason.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_daily_leave_select_time.dart';


class PlutoDailyLeaveApply extends StatelessWidget {
  const PlutoDailyLeaveApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
                builder: (BuildContext context, state) {
                  return Column(
                    children: [
                      ...List.generate(
                        context.read<DailyLeaveBloc>().leave?.length ?? 0,
                            (index) => Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Branding.colors.primaryLight,)), margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 4.r),
                          child: RadioListTile(contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                              title: Text(context.watch<DailyLeaveBloc>().leave?[index].title ?? '', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.r,fontWeight: FontWeight.w500,color: Branding.colors.textPrimary,)).tr(),
                              value: context.watch<DailyLeaveBloc>().leave?[index],
                              groupValue: state.leaveTypeModel,
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor:  Branding.colors.primaryLight,
                              onChanged: (value) {
                                context.read<DailyLeaveBloc>().add(SelectLeaveType(leaveTypeModel: value!));
                              }),
                        ),
                      ),
                      /// leave time select
                      const PlutoDailyLeaveSelectTime(),
                    ],
                  );
                }),
            /// daily leave reason
            const PlutoDailyLeaveReason(),
          ],
        ),
      ),
    );
  }
}

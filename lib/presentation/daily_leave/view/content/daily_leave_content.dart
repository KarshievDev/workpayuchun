import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';

import 'package:core/core.dart';
import '../../../../res/nav_utail.dart';
import '../../../attendance/content/animated_circular_button.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/daily_leave_event.dart';
import '../daily_create_page.dart';
import 'daily_leave_status/daily_leave_status_content.dart';

class DailyLeaveContent extends StatelessWidget {
  const DailyLeaveContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("daily_leave",), style: TextStyle(fontSize: 16.r),),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DailyLeaveBloc>().add(SelectDatePickerDailyLeave(user!.user!.id!, context));
              },
              icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          AnimatedHalfCircularButton(
              onComplete: () {
                NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                      value: context.read<DailyLeaveBloc>(),
                      child: const DailyCreatePage(),
                    ));
              },
              title: "apply_daily_leave".tr(),
              color: Branding.colors.primaryLight),
          const DailyLeaveStatusContent()
        ],
      ),
    );
  }
}

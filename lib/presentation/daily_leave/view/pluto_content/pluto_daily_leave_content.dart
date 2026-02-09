import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/attendance/content/animated_circular_button.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_daily_leave_status_content.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_daily_create_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';


class PlutoDailyLeaveContent extends StatelessWidget {
  const PlutoDailyLeaveContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(tr("daily_leave",), style: TextStyle(fontSize: 16.r,color: Branding.colors.textPrimary,fontWeight: FontWeight.w500),),
        actions: [
          InkWell(
            onTap: (){
              context.read<DailyLeaveBloc>().add(SelectDatePickerDailyLeave(user!.user!.id!, context));
            },
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
              child: Image.asset("assets/images/ic_calendar.png", height: 18.h, width: 18.w,),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          AnimatedHalfCircularButton(
            onComplete: () {
              NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<DailyLeaveBloc>(), child: const PlutoDailyCreatePage(),));
            },
            title: "apply_daily_leave".tr(), color: Branding.colors.primaryLight,
          ),
          const PlutoDailyLeaveStatusContent()
        ],
      ),
    );
  }
}

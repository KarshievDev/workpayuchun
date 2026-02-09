import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';

class PlutoDailyLeaveReason extends StatelessWidget {
  const PlutoDailyLeaveReason({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8),
      child: TextFormField(
        controller: context.read<DailyLeaveBloc>().reasonTextController,
        maxLines: 6,
        validator: (val) => val!.isEmpty ? "reason_can't_be_empty".tr() : null,
        style:  TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always, contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          hintText: 'write_reason'.tr(),
          hintStyle:  TextStyle(fontSize: 12.r),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Branding.colors.primaryLight, width: 2), borderRadius: const BorderRadius.all(Radius.circular(12.0)),),
          border:  OutlineInputBorder(borderSide: BorderSide(width: 2, color: Branding.colors.textPrimary), borderRadius:  const BorderRadius.all(Radius.circular(12.0)),),
          enabledBorder:  OutlineInputBorder(borderSide: BorderSide(width: 2, color: Branding.colors.textPrimary), borderRadius: const BorderRadius.all(Radius.circular(12.0)),),
        ),
      ),
    );
  }
}

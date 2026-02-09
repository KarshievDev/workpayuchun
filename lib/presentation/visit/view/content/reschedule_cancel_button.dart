import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/visit_cancel_page/visit_cancel_page.dart';
import 'package:strawberryhrm/presentation/visit/view/visit_reschedule/visit_reschedule.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class RescheduleCancelButton extends StatelessWidget {
  final int visitId;

  const RescheduleCancelButton({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 45.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                NavUtil.navigateScreen(
                  context,
                  BlocProvider.value(value: context.read<VisitBloc>(), child: VisitReschedule(visitId: visitId)),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              child:
                  Text(
                    'reschedule',
                    style: TextStyle(color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 14.0.r),
                  ).tr(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            height: 45.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                NavUtil.navigateScreen(
                  context,
                  BlocProvider.value(value: context.read<VisitBloc>(), child: VisitCancelPage(visitId: visitId)),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              child:
                  Text(
                    'cancel',
                    style: TextStyle(color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 14.0.r),
                  ).tr(),
            ),
          ),
        ),
      ],
    );
  }
}

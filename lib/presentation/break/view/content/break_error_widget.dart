import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/widgets/custom_button_widget1.dart';

class BreakErrorWidget extends StatelessWidget {
  const BreakErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/ic_error.png",height: 90.0,width: 90.0,),
        const SizedBox(height: 10,),
        Text("code_is_invalid_later".tr(),style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black54,),textAlign: TextAlign.center,),
        const SizedBox(height: 24.0),
        CustomButton1(
          onTap: () {
            Navigator.pop(context);
          },
          background: Branding.colors.primaryLight.withValues(alpha: 0.5),
          text: 'Try Again'.tr(),
          textSize: 14.r,
        ),
      ],
    );
  }
}

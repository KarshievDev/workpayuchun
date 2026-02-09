import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlutoDailyLeaveTile extends StatelessWidget {
  const PlutoDailyLeaveTile({super.key, required this.title, required this.value, this.onTap, required this.color});

  final String title;
  final String value;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight, width: 0.5),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Branding.colors.textPrimary, fontSize: 12.r),),
            SizedBox(height: 3.h,),
            Text(value, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14.r,color: color,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
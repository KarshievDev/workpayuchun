import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyLeaveTile extends StatelessWidget {
  const DailyLeaveTile(
      {super.key,
      required this.title,
      required this.value,
      this.onTap,
      required this.color});

  final String title;
  final String value;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.h),
        onTap: onTap,
        leading: Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black87, fontSize: 14.r),
        ),
        trailing: Text(
          value,
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14.r),
        ),
      ),
    );
  }
}

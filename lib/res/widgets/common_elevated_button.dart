import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core/core.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title, this.bgColor = colorPrimary,
  });

  final Function() onTap;
  final Widget title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize:  Size.fromHeight(40.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0.r),
        ),
      ),
      child: title,
    );
  }
}
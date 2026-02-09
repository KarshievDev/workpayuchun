import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  final Color bgColor;

  const ProfileMenuTile(
      {super.key,
      required this.iconData,
      required this.onPressed,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.all(DeviceUtil.isTablet ? 8.0.sp : 8.0),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12.0)),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}

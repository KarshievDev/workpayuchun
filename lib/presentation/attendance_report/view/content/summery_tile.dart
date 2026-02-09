import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class SummeryTile extends StatelessWidget {
  const SummeryTile(
      {super.key,
      required this.title,
      this.titleValue,
      required this.color,
      this.onTap});

  final String title;
  final String? titleValue;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 16).r,
          leading: Container(
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 12.r),
          ).tr(),
          trailing: titleValue != null
              ? Text(
                  titleValue!,
                  style: TextStyle(fontSize: 14.r),
                )
              : RectangularCardShimmer(
                  height: 30.h,
                  width: 20.w,
                ),
        ),
        Divider(
          height: 0.0,
          thickness: 1.r,
        )
      ],
    );
  }
}

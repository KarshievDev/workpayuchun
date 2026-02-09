import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWithSeeAll extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onTap;
  final Widget? child;
  final String title;

  const TitleWithSeeAll(
      {super.key,
      required this.context,
      required this.onTap,
      required this.title,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child ??
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                "see_all",
                style: TextStyle(fontSize: 14.0.r),
              ).tr(),
            ),
          )
        ],
      ),
    );
  }
}

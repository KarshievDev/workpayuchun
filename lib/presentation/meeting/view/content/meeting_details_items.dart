import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeetingDetailsItems extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const MeetingDetailsItems({super.key, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 130,
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 12.r),
              ).tr()),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    subTitle ?? '',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 12.r),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

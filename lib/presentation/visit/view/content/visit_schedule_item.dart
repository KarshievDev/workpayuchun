import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class VisitScheduleItem extends StatelessWidget {
  final Schedule? schedule;
  const VisitScheduleItem({super.key, this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schedule?.title ?? "",style: TextStyle(fontSize: 12.r),
          ).tr(),
          Text(
            schedule?.dateTime ?? "",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

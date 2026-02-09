import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravelCategoryGridViewCard extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const TravelCategoryGridViewCard({
    super.key, this.title, this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0).r,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(Icons.travel_explore_sharp, color: Branding.colors.primaryLight),
              SizedBox(width: 10.0.w),
              Expanded(
                child: Text(
                 title ??  'Travel Plan',
                  maxLines: 2,
                  style: TextStyle(fontSize: 12.r, color: Branding.colors.primaryLight),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
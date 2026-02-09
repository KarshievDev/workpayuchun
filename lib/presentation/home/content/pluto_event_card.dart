import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:core/core.dart';

class PlutoEventCard extends StatelessWidget {
  const PlutoEventCard({super.key, required this.data, this.days = false, this.onPressed});

  final TodayData? data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), side: BorderSide(color: Branding.colors.primaryLight)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: SizedBox(
              width: 100.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    '${data?.image}',
                    height: 20.h,
                    color: Branding.colors.primaryLight,
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.r,color: Branding.colors.primaryLight),
                      ).tr(),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            '${data?.number}',
                            style:
                                TextStyle(fontSize: 20.r, fontWeight: FontWeight.bold, height: 1.5, letterSpacing: 0.5,color: Branding.colors.primaryLight),
                          ),
                          if (days == true)
                            Text(
                              'days'.tr(),
                              style: TextStyle(
                                  color: Branding.colors.primaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 4,
                                  letterSpacing: 0.5),
                            ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

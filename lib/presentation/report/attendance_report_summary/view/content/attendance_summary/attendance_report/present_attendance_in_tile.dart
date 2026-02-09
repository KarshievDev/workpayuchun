import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/common/functions.dart';
import 'package:strawberryhrm/res/common/toast.dart';

class PresentAddressInTile extends StatelessWidget {
  const PresentAddressInTile({
    super.key,
    required this.dailyReport,
    required this.remoteModeIn,
  });

  final DailyReport dailyReport;
  final String? remoteModeIn;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: dailyReport.checkIn?.isNotEmpty == true,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(int.parse(
                    getInOutColor(status: dailyReport.checkInStatus))),
                style: BorderStyle.solid,
                width: 3.0,
              ),
              color: Color(
                  int.parse(getInOutColor(status: dailyReport.checkInStatus))),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DottedBorder(
              color: Colors.white,
              borderType: BorderType.RRect,
              radius: const Radius.circular(5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              strokeWidth: 1,
              child: Text(dailyReport.checkIn ?? "",
                style: TextStyle(color: Colors.white,
                    fontSize: DeviceUtil.isTablet ? 12.sp : 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {
              // getLocationIn(dailyReport);
              getReasonIn(dailyReport.checkInLocation);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: DeviceUtil.isTablet ? 16.w : 16,
                height: DeviceUtil.isTablet ? 16.h : 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueAccent),
                child: Center(
                    child: Text(
                  remoteModeIn ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceUtil.isTablet ? 10.sp : 10,
                      fontWeight: FontWeight.bold),
                ).tr()),
              ),
            ),
          ),
          Visibility(
            visible: dailyReport.checkInReason?.isNotEmpty == true,
            child: InkWell(
              onTap: () {
                getReasonIn(dailyReport.checkInReason);
              },
              child:  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(
                  Icons.article_outlined,
                  color: Colors.blue,
                  size: DeviceUtil.isTablet ? 18.sp : 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

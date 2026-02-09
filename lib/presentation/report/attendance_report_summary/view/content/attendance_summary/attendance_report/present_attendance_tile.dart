import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/common/functions.dart';
import 'package:strawberryhrm/res/common/toast.dart';
import 'present_attendance_in_tile.dart';
import 'present_attendance_out_tile.dart';

class PresentAttendanceTile extends StatelessWidget {
  final DailyReport dailyReport;

  const PresentAttendanceTile({super.key, required this.dailyReport});

  @override
  Widget build(BuildContext context) {
    String? remoteModeIn;
    String? remoteModeOut;

    // remote mode In -> Home or Office
    remoteModeIn =
        (int.tryParse(dailyReport.remoteModeIn ?? "1") == 0) ? "H" : "V";

// remote mode Out -> Home or Office
    remoteModeOut =
        (int.tryParse(dailyReport.remoteModeOut ?? "0") == 0) ? "H" : "V";

    return Padding(
      padding:  EdgeInsets.only(bottom: DeviceUtil.isTablet ? 20.0.r : 20),
      child: Row(
        children: [
          SizedBox(
            width: DeviceUtil.isTablet ? 100.w : 100,
            child: Column(
              children: [
                Text(
                  dailyReport.weekDay ?? "",
                  style:  TextStyle(color: Colors.black54, fontSize: DeviceUtil.isTablet ? 12.sp : 12),
                ),
                Text(
                  dailyReport.date ?? "",
                  style:  TextStyle(color: Colors.black54, fontSize: DeviceUtil.isTablet ? 20.sp : 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffF2F8FF),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Text(
                          "in",
                          style: TextStyle(
                            fontSize: DeviceUtil.isTablet ? 10.sp : 10,
                          ),
                        ).tr(),
                      ),
                       SizedBox(width: DeviceUtil.isTablet ? 20.0.w : 20),
                      PresentAddressInTile(
                          dailyReport: dailyReport, remoteModeIn: remoteModeIn),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffFCF6FF),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "out".tr(),
                          style:  TextStyle(
                            fontSize: DeviceUtil.isTablet ? 10.sp : 10,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dailyReport.checkOut?.isNotEmpty == true,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(getInOutColor(
                                      status: dailyReport.checkOutStatus))),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(getInOutColor(
                                    status: dailyReport.checkOutStatus))),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                strokeWidth: 1,
                                child: Text(
                                  dailyReport.checkOut ?? "",
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: DeviceUtil.isTablet ? 12.sp : 12,
                                      fontWeight: FontWeight.w600),
                                ).tr(),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            PresentAddressOutTile(
                                dailyReport: dailyReport,
                                remoteModeOut: remoteModeOut),
                            Visibility(
                              visible: dailyReport.checkOutReason?.isNotEmpty ==
                                  true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.checkOutReason);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: DeviceUtil.isTablet ? 18.r : 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

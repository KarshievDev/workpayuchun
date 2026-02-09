import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/common/toast.dart';

class PresentAddressOutTile extends StatelessWidget {
  const PresentAddressOutTile({
    super.key,
    required this.dailyReport,
    required this.remoteModeOut,
  });

  final DailyReport dailyReport;
  final String? remoteModeOut;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: dailyReport.remoteModeOut?.isNotEmpty == true,
      child: InkWell(
        onTap: () {
          getReasonIn(dailyReport.checkOutLocation);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.blueAccent),
            child: Center(
                child: Text(
              remoteModeOut ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ).tr()),
          ),
        ),
      ),
    );
  }
}

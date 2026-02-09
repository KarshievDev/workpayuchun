import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LeaveStatus extends StatelessWidget {
  final LeaveDetailsData? leaveDetailsData;
  final bool isCancelled;

  const LeaveStatus({
    super.key,
    this.leaveDetailsData,
    this.isCancelled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(
            int.parse(leaveDetailsData?.colorCode.toString() ?? "0xFF000000"),
          ),
          style: BorderStyle.solid,
          width: 3.0,
        ),
        color:
            isCancelled
                ? Colors.red
                : Color(
                  int.parse(
                    leaveDetailsData?.colorCode.toString() ?? "0xFF000000",
                  ),
                ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DottedBorder(
        color: Colors.white,
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        strokeWidth: 1,
        child: Text(
          isCancelled ? 'Cancelled' : leaveDetailsData?.status?.status ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: DeviceUtil.isTablet ? 20 : 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

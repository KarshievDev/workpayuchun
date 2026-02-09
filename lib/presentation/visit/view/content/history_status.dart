import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class HistoryStatus extends StatelessWidget {
  final History? myHistoryList;
  const HistoryStatus({super.key, this.myHistoryList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(int.parse(myHistoryList?.statusColor ?? "0xFF1FB89E")),
          style: BorderStyle.solid,
          width: 3.0,
        ),
        color: Color(int.parse(myHistoryList?.statusColor ?? "0xFF1FB89E")),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DottedBorder(
        color: Colors.white,
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        strokeWidth: 1,
        child: Text(
          myHistoryList?.status ?? "",
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
        ).tr(),
      ),
    );
  }
}

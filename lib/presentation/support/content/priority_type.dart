import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class PriorityType extends StatelessWidget {
  const PriorityType({
    super.key,
    this.supportModel,
  });

  final SupportModel? supportModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(int.parse(supportModel?.priorityColor ?? "0xFF000000")),
          style: BorderStyle.solid,
          width: 3.0,
        ),
        color: Color(int.parse(supportModel?.priorityColor ?? "0xFF000000")),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DottedBorder(
        color: Colors.white,
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        strokeWidth: 1,
        child: Text(
          supportModel?.priorityName ?? "",
          style: TextStyle(
              color: Colors.white, fontSize: 10.r, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

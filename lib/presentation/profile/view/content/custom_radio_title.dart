import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class CustomRadioTitle extends StatelessWidget {
  final Function(BodyPrioritySupport?) onChanged;
  final String title;
  final BodyPrioritySupport? value;
  final BodyPrioritySupport? groupValue;

  const CustomRadioTitle(
      {super.key,
      required this.onChanged,
      required this.title,
      this.value,
      this.groupValue});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          listTileTheme: const ListTileThemeData(horizontalTitleGap: 2)),
      child: RadioListTile<BodyPrioritySupport?>(
          contentPadding: EdgeInsets.zero,
          dense: true,
          value: value,
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 14.r),
          ),
          groupValue: groupValue,
          onChanged: onChanged),
    );
  }
}

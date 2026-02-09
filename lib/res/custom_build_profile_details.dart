import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildProfileDetails({String? title, String? description}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text("$title", style: TextStyle(fontSize: 13.r)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text("$description", style: TextStyle(fontSize: 13.r, color: Branding.colors.textSecondary)),
        ),
      ],
    ),
  );
}

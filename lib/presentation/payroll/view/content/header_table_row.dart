import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderTableRow extends StatelessWidget {
  const HeaderTableRow({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r),
      ),
    );
  }
}

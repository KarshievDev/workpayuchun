import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'attendance_report_summary/view/content/report_content.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
            iconTheme: IconThemeData(
                size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
            title: Text(
              'report_summary',
              style: TextStyle(fontSize: 16.r),
            ).tr(),
          ),
        ),
        body: const ReportContent());
  }
}

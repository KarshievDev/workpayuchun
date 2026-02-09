import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class EmployeeListShimmer extends StatelessWidget {
  const EmployeeListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DeviceUtil.isTablet ? 20.h : 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              ),
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              ),
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              ),
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              ),
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              ),
              SizedBox(
                height: DeviceUtil.isTablet ? 16.h : 16.0,
              ),
              RectangularCardShimmer(
                height: DeviceUtil.isTablet ? 80.h : 80.0,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

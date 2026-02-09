import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class GeneralListShimmer extends StatelessWidget {
  const GeneralListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          RectangularCardShimmer(
            height: 80.h,
            width: double.infinity,
          ),
          SizedBox(
            height: 10.h,
          ),
          RectangularCardShimmer(
            height: 80.0.h,
            width: double.infinity,
          ),
          SizedBox(
            height: 10.h,
          ),
          RectangularCardShimmer(
            height: 80.0.h,
            width: double.infinity,
          ),
          SizedBox(
            height: 10.h,
          ),
          RectangularCardShimmer(
            height: 80.0.h,
            width: double.infinity,
          ),
          SizedBox(
            height: 10.h,
          ),
          RectangularCardShimmer(
            height: 80.0.h,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

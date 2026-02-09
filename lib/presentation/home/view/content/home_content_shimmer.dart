import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/shimmers.dart';

class HomeContentShimmer extends StatelessWidget {
  const HomeContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.0.h),
          Row(children: [Expanded(child: TileShimmer(titleHeight: 12.0.h)), SizedBox(width: 120.0.w)]),
          const TileShimmer(isTrailing: true, isSubTitle: true),
          const HorizontalListShimmer(),
          SizedBox(height: 16.0.h),
          RectangularCardShimmer(height: 150.0.h, width: double.infinity),
          SizedBox(height: 16.0.h),
          RectangularCardShimmer(height: 150.0.h, width: double.infinity),
        ],
      ),
    );
  }
}

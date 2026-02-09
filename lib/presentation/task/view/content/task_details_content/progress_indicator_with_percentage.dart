import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressIndicatorWithPercentage extends StatelessWidget {
  const ProgressIndicatorWithPercentage(
      {super.key,
      this.activeContainerWidth,
      this.deActivateContainerWidth,
      this.percentageTextHeight,
      this.containerHeight,
      this.percentageActiveColor,
      this.percentageDisableColor,
      this.percentage});

  final Color? percentageActiveColor, percentageDisableColor;
  final double? activeContainerWidth,
      deActivateContainerWidth,
      containerHeight,
      percentageTextHeight;
  final String? percentage;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                color: percentageActiveColor),
            height: containerHeight ?? 4.0,
            width: activeContainerWidth,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: percentageDisableColor),
            height: containerHeight ?? 4.0,
            width: deActivateContainerWidth,
          ),
          const SizedBox(
            width: 9.0,
          ),
          Text(
            percentage ?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: percentageTextHeight ?? 11.0.r,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

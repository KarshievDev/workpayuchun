import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'content.dart';

class TaskDashboardCard extends StatelessWidget {
  const TaskDashboardCard(
      {super.key,
      this.title,
      this.count,
      required this.customPainter,
      this.titleColor,
      this.titleAsset,
      this.onTap});

  final String? title, count, titleAsset;
  final CustomPainter? customPainter;
  final Color? titleColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 72.r,
          height: 155.r,
          child: Stack(
            children: [
              Positioned(
                  top: 14,
                  left: 5,
                  right: 0,
                  child: TaskStatusCard(
                    image: titleAsset!,
                    title: title,
                    textColor: titleColor ?? Colors.black,
                  )),
              Positioned(
                top: 0,
                left: 0,
                child: CustomPaint(
                  size: Size(120.r, 55.r),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: customPainter,
                ),
              ),
              Positioned(
                  top: 8.r,
                  right: 0,
                  left: 53.r,
                  child: Text(
                    count ?? "0",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.r),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

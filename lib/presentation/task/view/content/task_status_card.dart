import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class TaskStatusCard extends StatelessWidget {
  const TaskStatusCard({super.key, this.title, this.image, this.textColor});

  final String? title, image;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 130.r,
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              image ?? "",
              height: 24.r,
              width: 24.r,
            ),
            const SizedBox(
              height: 10,
            ),
            title != null
                ? Text(
                    title!.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor ?? Colors.black,
                        fontSize: 16.r),
                  )
                : const RectangularCardShimmer(
                    height: 10,
                  )
          ],
        ),
      ),
    );
  }
}

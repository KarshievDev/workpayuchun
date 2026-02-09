import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class TypeContentItem extends StatelessWidget {
  final Function() onPressed;
  final AttendanceMethod method;
  final AnimationController animationController;
  final Animation animation;

  const TypeContentItem(
      {super.key,
      required this.onPressed,
      required this.method,
      required this.animationController,
      required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          return FadeTransition(
            opacity: kAlwaysCompleteAnimation,
            child: Transform(
              transform: Matrix4.translationValues(0.0, 50.0 * (1.0 - animation.value), 0.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0).r,
                ),
                child: TextButton(
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      method.title ?? '',
                      maxLines: 2,
                      style: TextStyle(fontSize: 15.r),
                    ).tr(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

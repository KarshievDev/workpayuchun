import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/dynamic_image_viewer.dart';

class PlutoMenuContentItem extends StatelessWidget {
  final Function() onPressed;
  final Menu menu;
  final AnimationController animationController;
  final Animation animation;

  const PlutoMenuContentItem(
      {super.key,
      required this.onPressed,
      required this.menu,
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0).r,
                    side: BorderSide(color: Branding.colors.primaryLight.withValues(alpha: 0.5                                                  ))),
                child: TextButton(
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DynamicImageViewer(
                          image: menu.icon ?? "",
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          menu.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.r,color: Branding.colors.primaryLight),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

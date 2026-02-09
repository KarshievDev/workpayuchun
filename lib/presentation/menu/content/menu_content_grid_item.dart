import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/dynamic_image_viewer.dart';

class MenuContentGridItem extends StatelessWidget {
  final Function() onPressed;
  final Menu menu;
  final AnimationController animationController;
  final Animation animation;

  const MenuContentGridItem({
    super.key,
    required this.onPressed,
    required this.menu,
    required this.animationController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: InkWell(
            onTap: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 8.0, bottom: 4.0, top: 4.0, left: 1.0),
                  decoration: BoxDecoration(
                    color: menu.color,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: menu.color?.withAlpha(50),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: DynamicImageViewer(image: menu.icon ?? "", width: 30.0, height: 30.0, color: menu.color),
                    ),
                    SizedBox(height: 8.0),
                    Text(menu.name ?? '', maxLines: 2, style: TextStyle(fontSize: 16.0, color: Colors.black)).tr(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

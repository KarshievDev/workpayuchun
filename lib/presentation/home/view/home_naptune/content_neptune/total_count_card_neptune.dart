import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomePageTotalCountCard extends StatelessWidget {
  const HomePageTotalCountCard(
      {super.key, this.image, this.title, this.count, this.onTap});

  final String? image;
  final String? title;
  final String? count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image ?? "assets/images/placeholder_image.png",
            height: 60,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count ?? "",
                  style: const TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Text(
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ).tr(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

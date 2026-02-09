import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BreakCardItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isChecked;
  final VoidCallback onTap;

  const BreakCardItem(
      {super.key, required this.onTap, this.icon, this.title, this.mainAxisAlignment, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Branding.colors.iconDisabled),
          color: isChecked ? Branding.colors.primaryLight : Colors.white,
          gradient: isChecked
              ? LinearGradient(colors: [Branding.colors.primaryLight, Branding.colors.primaryLight.withValues(alpha: 0.5)])
              : null,
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            CachedNetworkImage(
              imageUrl: icon ?? '',
              color: isChecked ? Branding.colors.iconInverse : Branding.colors.iconPrimary,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              title?.tr() ?? "",
              maxLines: 1,
              style: TextStyle(
                  color: isChecked ? Branding.colors.textInversePrimary : Branding.colors.textPrimary, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DynamicImageViewer extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Color? color;

  const DynamicImageViewer({
    super.key,
    required this.image,
    this.width = 25.0,
    this.height = 25.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return image.contains('svg') == true
        ? SvgPicture.network(
          image,
          height: height.h,
          width: width.w,
          colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
        )
        : CachedNetworkImage(imageUrl: image, height: height.h, width: width.w, color: color);
  }
}

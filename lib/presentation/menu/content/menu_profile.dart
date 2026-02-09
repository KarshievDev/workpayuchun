import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Container(
      width: 55.0.r,
      height: 55.0.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Branding.colors.iconSecondary, width: 2.0),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          height: 50.0.r,
          width: 50.0.r,
          fit: BoxFit.cover,
          imageUrl: "${user?.user?.avatar}",
          placeholder: (context, url) => Center(child: Image.asset("assets/images/placeholder_image.png")),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

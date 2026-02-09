import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strawberryhrm/presentation/bottom_navigation/bloc/bottom_nav_cubit.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final BottomNavTab tab;

  const BottomNavItem({super.key, required this.icon, required this.isSelected, required this.tab});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        children: [
          SvgPicture.asset(
            icon,
            height: 20.0,
            // color: isSelected ? colorPrimary : const Color(0xFF555555),
            colorFilter: ColorFilter.mode(isSelected ? Colors.white : Colors.white54, BlendMode.srcIn),
          ),
          Text(
            tab.name.tr(),
            style: TextStyle(color: isSelected ? Colors.white : Colors.white54,fontSize: 12.0),
          ),
        ],
      ),
      onPressed: () => context.read<BottomNavCubit>().setTab(tab),
    );
  }
}

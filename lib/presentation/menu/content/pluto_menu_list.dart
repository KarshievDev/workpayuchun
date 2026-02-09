import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/menu/content/pluto_menu_content_item.dart';

import '../../home/bloc/home_bloc.dart';
import '../bloc/menu_bloc.dart';

class PlutoMenuList extends StatelessWidget {
  final AnimationController? animationController;

  const PlutoMenuList({super.key, this.animationController});

  @override
  Widget build(BuildContext context) {
    final homeData = context.watch<HomeBloc>().state.dashboardModel;
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 65.0).r,
      itemCount: homeData?.data?.menus?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1,mainAxisSpacing: 4.0,crossAxisSpacing: 2.0),
      itemBuilder: (BuildContext context, int index) {
        ///List length
        int length = homeData?.data?.menus?.length ?? 0;

        ///Animation instance
        final animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController!, curve: Interval((1 / length) * index, 1.0, curve: Curves.fastOutSlowIn)));
        animationController?.forward();
        final menu = homeData?.data?.menus?[index];
        return menu != null
            ? PlutoMenuContentItem(
                menu: menu,
                animation: animation,
                animationController: animationController!,
                onPressed: () {
                  context.read<MenuBloc>().add(RouteSlug(context: context, slugName: menu.slug));
                })
            : const SizedBox.shrink();
      },
    );
  }
}

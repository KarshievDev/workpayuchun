import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/bloc/home_bloc.dart';
import '../bloc/menu_bloc.dart';
import 'menu_content_grid_item.dart';
import 'menu_content_list_item.dart';

class MenuScreenGridContent extends StatelessWidget {
  final AnimationController? animationController;

  const MenuScreenGridContent({super.key, this.animationController});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8.0),
                itemCount: state.gridMenus.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.1.r),
                itemBuilder: (BuildContext context, int index) {
                  ///List length
                  int length = state.gridMenus.length;

                  ///Animation instance
                  final animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / length) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  final menu = state.gridMenus[index];
                  return MenuContentGridItem(
                    menu: menu,
                    animation: animation,
                    animationController: animationController!,
                    onPressed: () {
                      context.read<MenuBloc>().add(RouteSlug(context: context, slugName: menu.slug));
                    },
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 55.0).r,
                itemCount: state.listMenus.length,
                itemBuilder: (BuildContext context, int index) {
                  ///List length
                  int length = state.listMenus.length;

                  ///Animation instance
                  final animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / length) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  final menu = state.listMenus[index];
                  return MenuContentListItem(
                    menu: menu,
                    animation: animation,
                    animationController: animationController!,
                    onPressed: () {
                      context.read<MenuBloc>().add(RouteSlug(context: context, slugName: menu.slug));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

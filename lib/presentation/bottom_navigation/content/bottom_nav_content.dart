import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:strawberryhrm/presentation/home/router/home__menu_router.dart';
import 'package:strawberryhrm/presentation/leave/view/leave_page.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import '../../home/view/home_page.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'bottom_nav_item.dart';

class BottomNavContent extends StatelessWidget {
  const BottomNavContent({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    final selectedTab = context.select((BottomNavCubit cubit) => cubit.state.tab);

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (_, __) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: Branding.colors.primaryDark, // navigation bar color
            statusBarColor: Branding.colors.primaryDark, // status bar color
          ),
        );

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            final differences = DateTime.now().difference(timeBackPressed);
            timeBackPressed = DateTime.now();
            if (differences >= const Duration(seconds: 2)) {
              String msg = "press_back_button_to_exit".tr();
              Fluttertoast.showToast(msg: msg);
            } else {
              Fluttertoast.cancel();
              SystemNavigator.pop();
            }
          },
          child: Scaffold(
            extendBody: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar(automaticallyImplyLeading: false),
            ),
            bottomNavigationBar: ColoredBox(
              color: Colors.white,
              child: BottomAppBar(
                elevation: 4,
                color: Branding.colors.primaryDark,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BottomNavItem(
                      icon: 'assets/home_icon/home.svg',
                      isSelected: selectedTab == BottomNavTab.home,
                      tab: BottomNavTab.home,
                    ),
                    BottomNavItem(
                      icon: 'assets/home_icon/leave.svg',
                      isSelected: selectedTab == BottomNavTab.leave,
                      tab: BottomNavTab.leave,
                    ),
                    BottomNavItem(
                      icon: 'assets/home_icon/menu_icon.svg',
                      isSelected: selectedTab == BottomNavTab.menu,
                      tab: BottomNavTab.menu,
                    ),
                    BottomNavItem(
                      icon: 'assets/home_icon/notifications.svg',
                      isSelected: selectedTab == BottomNavTab.notification,
                      tab: BottomNavTab.notification,
                    ),
                  ],
                ),
              ),
            ),
            body: IndexedStack(
              index: selectedTab.index,
              children: [const HomePage(), const LeavePage(), chooseMenu(), chooseNotification()],
            ),
          ),
        );
      },
    );
  }
}

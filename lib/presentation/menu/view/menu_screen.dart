import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import 'package:strawberryhrm/presentation/menu/bloc/menu_bloc.dart';
import 'package:strawberryhrm/presentation/menu/content/greetings_content.dart';
import 'package:strawberryhrm/presentation/menu/content/menu_screen_grid_content.dart';
import 'package:strawberryhrm/presentation/menu/content/menu_profile.dart';
import 'package:strawberryhrm/presentation/menu_drawer/view/menu_drawer.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../profile/view/profile_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create:
          (context) =>
              MenuBloc(
                  loginData: user!,
                  color: colorPrimary,
                  getAppName: instance<GetAppNameUseCase>(),
                  getAppVersion: instance<GetAppVersionUseCase>(),
                )
                ..add(RouteSlug(context: context))
                ..add(OnAppServiceEvent()),
      child: Scaffold(
        key: MenuScreen._scaffoldKey,
        drawer: const MenuDrawer(),
        extendBody: true,
        backgroundColor: Branding.colors.primaryDark,
        body: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Branding.colors.primaryDark, Branding.colors.primaryLight],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header
                  InkWell(
                    onTap: () {
                      Navigator.push(context, ProfileScreen.route(user?.user?.id));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
                            child: IconButton(
                              onPressed: () {
                                if (MenuScreen._scaffoldKey.currentState!.isEndDrawerOpen) {
                                  MenuScreen._scaffoldKey.currentState?.openDrawer();
                                } else {
                                  MenuScreen._scaffoldKey.currentState?.openDrawer();
                                }
                              },
                              icon: Icon(Icons.menu, color: Colors.white, size: 30.r),
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                user?.user?.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r, color: Colors.white),
                              ),
                              GreetingsContent(),
                            ],
                          ),
                          Spacer(),
                          const MenuProfile(),
                          SizedBox(width: 16.w),
                        ],
                      ),
                    ),
                  ),

                  /// Menu List
                  MenuScreenGridContent(animationController: animationController),

                  const SizedBox(height: 36.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

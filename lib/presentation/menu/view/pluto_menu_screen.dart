import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import 'package:strawberryhrm/presentation/menu/bloc/menu_bloc.dart';
import 'package:strawberryhrm/presentation/menu/content/menu_profile.dart';
import 'package:strawberryhrm/presentation/menu/content/pluto_menu_header.dart';
import 'package:strawberryhrm/presentation/menu/content/pluto_menu_list.dart' show PlutoMenuList;
import 'package:strawberryhrm/presentation/menu_drawer/view/menu_drawer.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_profile_page.dart';

class PlutoMenuScreen extends StatefulWidget {
  const PlutoMenuScreen({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<PlutoMenuScreen> createState() => _PlutoMenuScreenState();
}

class _PlutoMenuScreenState extends State<PlutoMenuScreen> with TickerProviderStateMixin {
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
        create: (context) => MenuBloc(
            loginData: user!,
            color: colorPrimary,
            getAppName: instance<GetAppNameUseCase>(),
            getAppVersion: instance<GetAppVersionUseCase>())
          ..add(RouteSlug(context: context))
          ..add(OnAppServiceEvent()),
        child: Scaffold(
            key: PlutoMenuScreen._scaffoldKey,
            endDrawer: const MenuDrawer(),
            extendBody: true,
            body: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
              return Column(
                children: [
                  /// Header
                  InkWell(
                    onTap: () {
                      Navigator.push(context, PlutoProfileScreen.route(user?.user?.id));
                    },
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.only(top: 30.0),
                      color: Branding.colors.primaryLight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
                        child: Row(
                          children: [
                            const MenuProfile(),
                            SizedBox(
                              width: 16.w,
                            ),
                            const PlutoMenuHeader(),
                            IconButton(
                                onPressed: () {
                                  if (PlutoMenuScreen._scaffoldKey.currentState!.isEndDrawerOpen) {
                                    PlutoMenuScreen._scaffoldKey.currentState?.openEndDrawer();
                                  } else {
                                    PlutoMenuScreen._scaffoldKey.currentState?.openEndDrawer();
                                  }
                                },
                                icon: Image.asset('assets/images/bergur_menu.png', height: 20.0.h, width: 20.0.w, fit: BoxFit.cover, color: Colors.white,))
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Menu List
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                      child: PlutoMenuList(
                        animationController: animationController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36.0)
                ],
              );
            })));
  }
}

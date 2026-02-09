import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/home/home.dart';
import 'package:strawberryhrm/presentation/home/router/home__menu_router.dart';
import 'package:user_repository/user_repository.dart';
import 'package:core/core.dart';

class HomeHeader extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeHeader({super.key, required this.settings, required this.user, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(right: 0, left: 0,
          child: Image.asset('assets/images/home_background_one.png',
            height: 200.0.h,
            fit: BoxFit.cover,
            color: Branding.colors.primaryLight,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0.h),
            Row(
              children: [
                Expanded(flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(settings?.data?.timeWish?.wish ?? dashboardModel?.data?.config?.timeWish?.wish ?? '', style: TextStyle(fontSize: 20.r, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('${user?.user?.name}',
                          style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold, height: 1.5, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          settings?.data?.timeWish?.subTitle ?? dashboardModel?.data?.config?.timeWish?.wish ?? '',
                          style:
                              TextStyle(fontSize: 14.r, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                if (settings?.data?.timeWish != null || dashboardModel?.data?.config?.timeWish != null)
                  SvgPicture.network(
                    settings?.data?.timeWish?.image ?? dashboardModel?.data?.config?.timeWish?.image ?? '',
                    semanticsLabel: 'sun',
                    height: 60.h,
                    width: 60.w,
                    placeholderBuilder: (BuildContext context) => const SizedBox(),
                  ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 16.0.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'today_summary'.tr(),
                style: TextStyle(
                    fontSize: 16.r, fontWeight: FontWeight.w500, height: 1.5, color: Colors.white, letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 8.0.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                  children: List.generate(
                dashboardModel?.data?.today?.length ?? 0,
                (index) => EventCard(
                  data: dashboardModel?.data?.today![index],
                  onPressed: () => routeSlug(dashboardModel?.data?.today![index].slug, context),
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/language/view/language_screen.dart';
import 'package:strawberryhrm/presentation/menu_drawer/content/privacy_policy_content.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

import '../../language/bloc/language_bloc.dart';

class SupportContent extends StatelessWidget {
  const SupportContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'setting',
              style: TextStyle(color: Colors.grey, fontSize: 14.r),
            ).tr(),
            const Divider(),
            ListTile(
              onTap: () {
                NavUtil.navigateScreen(context, const LanguageScreen());
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              textColor: Colors.grey,
              horizontalTitleGap: 8.r,
              title: Text(
                "language_change",
                style: TextStyle(fontSize: 14.r),
              ).tr(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'support',
              style: TextStyle(color: Colors.grey, fontSize: 14.r),
            ).tr(),
            const Divider(),
            ListTile(
              onTap: () {
                NavUtil.navigateScreen(
                    context,
                    const PolicyContentScreen(
                      appBarName: "support_policy",
                      apiSlug: "support-24-7",
                    ));
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              textColor: Colors.grey,
              horizontalTitleGap: 8,
              title: Text('support_policy', style: TextStyle(fontSize: 14.r)).tr(),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                NavUtil.navigateScreen(
                    context,
                    const PolicyContentScreen(
                      appBarName: "privacy_policy",
                      apiSlug: "privacy-policy",
                    ));
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              textColor: Colors.grey,
              horizontalTitleGap: 8,
              title: Text('privacy_policy', style: TextStyle(fontSize: 14.r)).tr(),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                NavUtil.navigateScreen(
                    context,
                    const PolicyContentScreen(
                      appBarName: "terms_conditions",
                      apiSlug: "terms-of-use",
                    ));
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 8,
              textColor: Colors.grey,
              title: Text('terms_conditions', style: TextStyle(fontSize: 14.r)).tr(),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
              return ListTile(
                onTap: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: const Text('are_you_sure_you_want_to_logout').tr(),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('no').tr()),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequest());
                            context.read<HomeBloc>().add(OnResetEvent());
                            Navigator.of(context).pop();
                          },
                          child: const Text('yes').tr()),
                    ],
                  ),
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 8,
                textColor: Colors.grey,
                iconColor: Colors.grey,
                leading: SvgPicture.asset(
                  "assets/menu_drawer_icons/logout.svg",
                  height: 20.r,
                  width: 20.r,
                ),
                title: Text('logout', style: TextStyle(fontSize: 14.r)).tr(),
              );
            })
          ],
        );
      },
    );
  }
}

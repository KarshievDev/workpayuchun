import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/password_change/view/password_change_page.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import '../../../../res/custom_build_profile_details.dart';

class OfficialProfileContent extends StatelessWidget {
  final Profile profile;
  final Settings? settings;

  const OfficialProfileContent(
      {super.key, required this.profile, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildProfileDetails(
              title: "name".tr(), description: profile.official?.name ?? "N/A"),
          buildProfileDetails(
              title: "email".tr(),
              description: profile.official?.email ?? "N/A"),
          buildProfileDetails(
              title: "designation".tr(),
              description: profile.official?.designation ?? "N/A"),
          buildProfileDetails(
              title: "department".tr(),
              description: profile.official?.department ?? "N/A"),
          buildProfileDetails(
              title: "manager".tr(),
              description: profile.official?.designation ?? "N/A"),
          buildProfileDetails(
              title: "date_of_joining".tr(),
              description: profile.official?.joiningDate ?? "N/A"),
          buildProfileDetails(
            title: "employee_type".tr(),
            description: profile.official?.employeeType ?? "N/A",
          ),
          buildProfileDetails(
              title: "employee_id".tr(),
              description: profile.official?.employeeId ?? "N/A"),
          const SizedBox(
            height: 10,
          ),
          CustomHButton(
            padding: 0.0,
            radius: 0.0,
            backgroundColor: Branding.colors.primaryDark,
            title: "change_password".tr(),
            clickButton: () {
              NavUtil.navigateScreen(context, const PasswordChangePage());
            },
          )
        ],
      ),
    );
  }
}

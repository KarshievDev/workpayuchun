import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../bloc/profile/profile_bloc.dart';

class EmergencyProfileContent extends StatelessWidget {
  final Profile profile;
  final Settings? settings;

  const EmergencyProfileContent(
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
              title: "name".tr(),
              description: profile.emergency?.name ?? "N/A"),
          buildProfileDetails(
              title: "mobile_number".tr(),
              description: profile.emergency?.mobile ?? "N/A"),
          buildProfileDetails(
              title: "relationship".tr(),
              description: profile.emergency?.relationship ?? "N/A"),
          const SizedBox(
            height: 24.0,
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0.h,
                  child: ElevatedButton(
                    onPressed:
                        () => showDialog(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                        content: Text('Are_you_sure_,_you_want_to_delete_the_account'.tr()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<ProfileBloc>(context).add(ProfileDeleteRequest());
                              BlocProvider.of<AuthenticationBloc>(
                                context,
                              ).add(AuthenticationLogoutRequest());
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Text('delete_account'.tr(), style: TextStyle(fontSize: 14.r, color: Colors.white)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

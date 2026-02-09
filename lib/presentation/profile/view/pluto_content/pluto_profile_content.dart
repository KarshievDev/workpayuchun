import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/password_change/view/pluto_password_change_page.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_emergency_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_finalcial_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_official_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_personal_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_profile_header.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class PlutoProfileContent extends StatelessWidget {
  final Settings? settings;

  const PlutoProfileContent({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        if (state.profile != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                PlutoProfileHeader(state: state,),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<ProfileBloc>(),
                          child: PlutoOfficialProfileContent(profile: state.profile!, settings: settings, state: state,),)));
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(
                      leading: Image.asset("assets/images/ic_apartment.png", height: 24, width: 24,),
                      title: Text("Official Information", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Branding.colors.textSecondary,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<ProfileBloc>(),
                      child: PlutoPersonalProfileContent(profile: state.profile!, settings: settings, state: state,),)));
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(
                      leading: Image.asset("assets/images/ic_user.png", height: 24, width: 24,),
                      title: Text("Personal Information", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Branding.colors.textSecondary,),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<ProfileBloc>(),
                      child: PlutoFinancialProfileContent(profile: state.profile!, settings: settings, state: state,),)));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(
                      leading: Image.asset("assets/images/ic_financial.png", height: 24, width: 24,),
                      title: Text("Financial Information", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Branding.colors.textSecondary,),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(value: context.read<ProfileBloc>(),
                      child: PlutoEmergencyProfileContent(profile: state.profile!, settings: settings, state: state,),)));
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(leading: Image.asset("assets/images/ic_emergency.png", height: 24, width: 24,),
                      title: Text("Emergency Information", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Branding.colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){
                    NavUtil.navigateScreen(context, const PlutoPasswordChangePage());
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(
                      leading: Image.asset("assets/images/ic_password.png", height: 24, width: 24,),
                      title: Text("Change Password", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Branding.colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){
                    BlocProvider.of<ProfileBloc>(context).add(ProfileDeleteRequest());
                    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequest());
                    Navigator.of(context).pop();
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Branding.colors.primaryLight)),
                    child: ListTile(
                      leading: Image.asset("assets/images/ic_logout.png", height: 24, width: 24,),
                      title: Text("Logout", style: TextStyle(color: Branding.colors.textSecondary),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Branding.colors.textSecondary,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context,state){
                  return InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content: Text(
                              'Are_you_sure_,_you_want_to_delete_the_account'
                                  .tr()),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(ProfileDeleteRequest());
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationLogoutRequest());
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes')),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      "Delete Account",
                      style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }
      }
      if (state.status == NetworkStatus.failure) {
        return Center(
          child: Text('failed_to_load_profile'.tr()),
        );
      }
      return const SizedBox();
    });
  }
}

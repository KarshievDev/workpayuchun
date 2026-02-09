import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_edit_profile_info.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_profile_header.dart';

class PlutoFinancialProfileContent extends StatelessWidget {
  final Profile profile;
  final Settings? settings;
  final ProfileState? state;
  const PlutoFinancialProfileContent({super.key, required this.profile, required this.settings,this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(tr("Financial Info"), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Branding.colors.textSecondary,),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(PlutoEditOfficialInfo.route(bloc: context.read<ProfileBloc>(),pageName: 'financial', settings: settings, profile: profile));
              },
              icon: Icon(Icons.edit_outlined, color: Branding.colors.textSecondary,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            PlutoProfileHeader(state: state,),
            const SizedBox(height: 20,),
            Container(margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight), borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("tin".tr())),
                      Expanded(flex: 2, child: Text(": ${profile.financial?.tin ?? "N/A"}".tr()))],),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("bank_name".tr())),
                      Expanded(flex: 2, child: Text(": ${profile.financial?.bankName ?? "N/A"}".tr()))],),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("bank_account_no".tr())),
                      Expanded(flex: 2, child: Text(": ${profile.financial?.bankAccount ?? "N/A"}".tr()))],),

               ],
              ),
            ),
            const SizedBox(height: 24.0,),
          ],
        ),
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/pluto_content/pluto_profile_content.dart';

class PlutoProfileScreen extends StatelessWidget {
  const PlutoProfileScreen({super.key, this.id, this.settings});
  final int? id;
  final Settings? settings;

  static Route route(int? userId) => MaterialPageRoute(builder: (_) => PlutoProfileScreen(id: userId));

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => ProfileBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(ProfileLoadRequest()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('profile',style: TextStyle(color: Branding.colors.textSecondary,fontSize: 16,fontWeight: FontWeight.bold),).tr(),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Branding.colors.textSecondary),),
        body: PlutoProfileContent(settings: settings,),
      ),
    );
  }
}

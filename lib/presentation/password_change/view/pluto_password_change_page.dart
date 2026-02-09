import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/password_change/bloc/password_change_bloc.dart';
import 'package:strawberryhrm/presentation/password_change/content/pluto_password_change_content.dart';

class PlutoPasswordChangePage extends StatelessWidget {
  const PlutoPasswordChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordChangeBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()),),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(tr("Change Password"), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Branding.colors.textSecondary,),
        ),
        body: const PlutoPasswordChangeContent(),
      ),
    );
  }
}

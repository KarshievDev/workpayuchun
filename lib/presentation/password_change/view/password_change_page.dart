import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/password_change/bloc/password_change_bloc.dart';
import 'package:strawberryhrm/presentation/password_change/content/password_change_content.dart';

class PasswordChangePage extends StatelessWidget {
  const PasswordChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (context) => PasswordChangeBloc(
        metaClubApiClient: MetaClubApiClient(
            httpService: instance()),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr("change_password")),
        ),
        body: const PasswordChangeContent(),
      ),
    );
  }
}

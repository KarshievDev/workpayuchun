import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/conference/conference.dart';

class ConferencePage extends StatelessWidget {
  const ConferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create:
          (_) =>
              ConferenceBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))
                ..add(ConferenceInitialDataRequest()),
      child: const ConferenceContentScreen(),
    );
  }
}

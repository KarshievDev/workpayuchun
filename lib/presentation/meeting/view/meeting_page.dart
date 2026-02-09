import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/meeting/bloc/meeting_bloc.dart';
import 'content/meeting_content.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeetingBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(MeetingListEvent()),
      child: const MeetingContent(),
    );
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/content/daily_leave_content.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/daily_leave_event.dart';

class DailyLeavePage extends StatelessWidget {
  const DailyLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (context) {
        final bloc = DailyLeaveBloc(
          metaClubApiClient: MetaClubApiClient(httpService: instance()),
        );

        return bloc..add(DailyLeaveSummary(user!.user!.id!));
      },
      child: const DailyLeaveContent(),
    );
  }
}

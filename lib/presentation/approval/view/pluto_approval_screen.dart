import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/approval/approval.dart';
import 'package:strawberryhrm/presentation/approval/view/pluto_content/pluto_approval_screen_content.dart';

class PlutoApprovalScreen extends StatelessWidget {
  const PlutoApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ApprovalBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(ApprovalInitialDataRequest()),
        child: const PlutoApprovalScreenContent());
  }
}

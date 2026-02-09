import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/payroll/bloc/payroll_bloc.dart';
import 'package:strawberryhrm/presentation/payroll/view/content/payroll_screen_content.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PayrollBloc(
          metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(PayrollInitialDataRequest()),
      child: const PayrollScreenContent(),
      );
  }
}

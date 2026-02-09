import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/task/view/content/content.dart';
import '../bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
        create: (_) => TaskBloc(
            metaClubApiClient: MetaClubApiClient(
                httpService: instance()))
          ..add(TaskInitialDataRequest()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'task',
              style: TextStyle(fontSize: 18.r),
            ).tr(),
          ),
          body: const TaskScreenContent(),
        ));
  }
}

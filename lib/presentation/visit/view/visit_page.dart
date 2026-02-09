import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_content.dart';

class VisitPage extends StatelessWidget {
  const VisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    globalState.get(companyUrl);
    return BlocProvider(
      create: (_) => VisitBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(VisitListEvent())
        ..add(HistoryListEvent()),
      child: const VisitContent(),
    );
  }
}

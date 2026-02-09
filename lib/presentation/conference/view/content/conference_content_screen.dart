import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/conference/conference.dart';
import 'package:strawberryhrm/presentation/conference/view/create_conference_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';


class ConferenceContentScreen extends StatelessWidget {
  const ConferenceContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<ConferenceBloc>(), child: const CreateConferencePage()));
        },
        child: Icon(Icons.add, size: 24.r, color: colorPrimary),
      ),
      appBar: AppBar(
        title: Text('Conference'.tr()),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ConferenceBloc>().add(ConferenceInitialDataRequest());
        },
        child: BlocBuilder<ConferenceBloc, ConferenceState>(
            builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TileShimmer(isSubTitle: true),
                );
              },
            );
          } else {
            return const ConferenceList();
          }
        }),
      ),
    );
  }
}

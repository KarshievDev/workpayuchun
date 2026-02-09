import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/meeting/bloc/meeting_bloc.dart';
import 'package:strawberryhrm/presentation/meeting/view/content/meeting_create_contecnt.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../leave/view/content/general_list_shimmer.dart';

class MeetingCreatePage extends StatelessWidget {
  const MeetingCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    MeetingBodyModel meetingBodyModel = MeetingBodyModel();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<MeetingBloc, MeetingState>(
                builder: (context, state) {
                  return CustomHButton(
                    title: "create_meeting".tr(),
                    padding: 16,
                    isLoading: state.status == NetworkStatus.loading,
                    clickButton: () {
                      final currentDate = DateFormat('y-MM').format(DateTime.now());
                      if (formKey.currentState!.validate() && state.status == NetworkStatus.success) {
                        meetingBodyModel.startAt = state.startTime;
                        meetingBodyModel.endAt = state.endTime;
                        meetingBodyModel.date = state.currentMonthSchedule;
                        context.read<MeetingBloc>().add(CreateMeetingEvent(
                            bodyCreateMeeting: meetingBodyModel,
                            date: currentDate,
                            context: context));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title: const Text("meeting_create").tr(),
        ),
        body: BlocBuilder<MeetingBloc, MeetingState>(
          builder: (context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GeneralListShimmer(),
              );
            } else if (state.status == NetworkStatus.success) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MeetingCreateContent(meetingBodyModel: meetingBodyModel),
                ),
              );
            } else if (state.status == NetworkStatus.failure) {
              return Center(child: const Text('failed_to_load_list').tr());
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

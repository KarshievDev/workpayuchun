import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/content/floating_button.dart';
import 'contect/travel_meeting_left_side_widget.dart';
import 'contect/travel_meeting_right_side_widget.dart';
import 'create_travel_meeting.dart';

class TravelMeetingListScreen extends StatelessWidget {
  const TravelMeetingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) =>
                      BlocProvider.value(value: context.read<TravelMeetingBloc>(), child: const CreateTravelMeeting()),
            ),
          );
        },
      ),
      body: BlocBuilder<TravelMeetingBloc, TravelMeetingState>(
        builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: GeneralListShimmer());
          } else if (state.status == NetworkStatus.success) {
            return Container(
              decoration: const BoxDecoration(color: bgColor),
              child:
                  state.travelMeetingModel?.data?.data?.isNotEmpty == true
                      ? ListView.builder(
                        itemCount: state.travelMeetingModel?.data?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          MeetingData? meetingResponse = state.travelMeetingModel?.data?.data?[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                child: Row(
                                  children: [
                                    const Expanded(flex: 4, child: TravelMeetingLeftSideWidget()),
                                    Expanded(
                                      flex: 8,
                                      child: TravelMeetingRightWidget(meetingResponse: meetingResponse),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      : const NoDataFoundWidget(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

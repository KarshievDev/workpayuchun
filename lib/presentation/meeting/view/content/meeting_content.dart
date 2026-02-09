import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/content/upcoming_event_widgetg.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/meeting/bloc/meeting_bloc.dart';
import 'package:strawberryhrm/presentation/meeting/view/meeting_create_page/meeting_create_page.dart';
import 'package:strawberryhrm/presentation/meeting/view/meeting_details_page/meeting_details_page.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class MeetingContent extends StatelessWidget {
  const MeetingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<MeetingBloc>(), child: const MeetingCreatePage()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("meeting_list").tr(),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<MeetingBloc>().add(SelectDatePicker(context));
                },
                icon: Icon(Icons.calendar_month_outlined,size: 24.r,))
          ],
        ),
        body: BlocBuilder<MeetingBloc, MeetingState>(
          builder: (BuildContext context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GeneralListShimmer(),
              );
            } else if (state.status == NetworkStatus.success) {
              return Column(
                children: [
                  state.meetingsListResponse?.data?.items?.isNotEmpty == true
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.meetingsListResponse?.data?.items?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.meetingsListResponse?.data?.items?[index];
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      NavUtil.navigateScreen(context,
                                          MeetingDetailsPage(data: data));
                                    },
                                    child: EventWidgets(
                                        isAppointment: true, data: data!),
                                  ));
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: NoDataFoundWidget(
                            title: 'no_data_found'.tr(),
                          )),
                        )
                ],
              );
            } else if (state.status == NetworkStatus.failure) {
              return Center(
                child: Text(
                  "failed_to_load_meeting_list".tr(),
                  style: TextStyle(
                      color: colorPrimary.withValues(alpha: 0.4),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}

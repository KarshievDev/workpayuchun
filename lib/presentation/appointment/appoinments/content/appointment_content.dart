import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/bloc/appointment_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/content/appointment_details_content.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/content/upcoming_event_widgetg.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/view/appointment_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class AppointmentContent extends StatelessWidget {
  const AppointmentContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        bloc = context.read<AppointmentBloc>();

        return Column(
          children: [
            state.meetingsListData?.data?.items?.isNotEmpty == true
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          state.meetingsListData?.data?.items?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            state.meetingsListData?.data?.items?[index];
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                              onTap: () {
                                NavUtil.navigateScreen(
                                    context,
                                    AppointmentDetailsScreen(
                                      data: data,
                                    ));
                              },
                              child: EventWidgets(
                                  isAppointment: true, data: data!),
                            ));
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                      tr("no_appointment_found"),
                      style: const TextStyle(
                          color: Color(0x65555555),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    )),
                  )
          ],
        );
      }
      if (state.status == NetworkStatus.failure) {
        return Center(child: Text('failed_to_load_appointment_list'.tr()));
      }
      return const SizedBox();
    });
  }
}

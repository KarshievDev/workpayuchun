import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/bloc/appointment_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/view/appointment_create_screen.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/content/appointment_content.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

AppointmentBloc? bloc;

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBloc(
          metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(GetAppointmentData()),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    AppointmentCreateScreen(
                      appointmentBloc: bloc,
                    ));
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(
                tr(
                  "appointments",
                ),
                style: TextStyle(fontSize: 18.r),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      context
                          .read<AppointmentBloc>()
                          .add(SelectDatePicker(context));
                    },
                    icon: const Icon(Icons.calendar_month_outlined))
              ],
            ),
            body: const AppointmentContent(),
          );
        },
      ),
    );
  }
}

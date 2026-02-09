import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appoinments/bloc/appointment_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/bloc/appointment_create_bloc.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/content/appointment_create_content.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/content/appointment_with_cart.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/content/attachment_content.dart';

class AppointmentCreateScreen extends StatefulWidget {
  final AppointmentBloc? appointmentBloc;

  const AppointmentCreateScreen({super.key, this.appointmentBloc});

  @override
  State<AppointmentCreateScreen> createState() =>
      _AppointmentCreateScreenState();
}

class _AppointmentCreateScreenState extends State<AppointmentCreateScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    AppointmentBody appointmentBody = AppointmentBody();
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (context) => AppointmentCreateBloc(
          appointmentBloc: widget.appointmentBloc,
          metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(LoadAppointmentCreateData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("appointment_create"),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: BlocBuilder<AppointmentCreateBloc, AppointmentCreateState>(
          builder: (context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == NetworkStatus.success) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppointmentCreateContent(
                            state: state, appointmentBody: appointmentBody),
                        AppointmentWithCart(state: state),
                        const SizedBox(
                          height: 25,
                        ),
                        AttachmentContent(appointmentBody: appointmentBody),
                        const SizedBox(
                          height: 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Branding.colors.primaryLight,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                appointmentBody.date = state.currentMonth;
                                appointmentBody.appointmentStartDate =
                                    state.startTime;
                                appointmentBody.appointmentEndDate =
                                    state.endTime;
                                appointmentBody.appointmentWith =
                                    state.selectedEmployee?.id;
                                context.read<AppointmentCreateBloc>().add(
                                    CreateButton(context, appointmentBody));
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Branding.colors.primaryLight),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Text(tr("create"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0.r,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state.status == NetworkStatus.failure) {
              return const Center(
                  child: Text('Failed to load Appointment list'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

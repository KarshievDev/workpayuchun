import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/bloc/appointment_create_bloc.dart';

class AppointmentCreateButton extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentCreateButton({
    super.key,
    required this.formKey,
    required this.appointmentBody,
    this.state,
  });

  final GlobalKey<FormState> formKey;
  final AppointmentBody appointmentBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            appointmentBody.date = state?.currentMonth;
            appointmentBody.appointmentStartDate = state?.startTime;
            appointmentBody.appointmentEndDate = state?.endTime;
            appointmentBody.appointmentWith = state?.selectedEmployee?.id;
            context
                .read<AppointmentCreateBloc>()
                .add(CreateButton(context, appointmentBody));
          }
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(tr("create"),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
      ),
    );
  }
}

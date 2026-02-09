import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/bloc/appointment_create_bloc.dart';

class AppointmentTimeCart extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentTimeCart({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("start_time"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.r),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    context.read<AppointmentCreateBloc>().add(SelectStartTime(
                          context,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state?.startTime ?? tr("start_time"),
                          style: TextStyle(fontSize: 14.r),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("end_time"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.r),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    context.read<AppointmentCreateBloc>().add(SelectEndTime(
                          context,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state?.endTime ?? tr("end_time"),
                          style: TextStyle(fontSize: 14.r),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/bloc/appointment_create_bloc.dart';
import 'package:strawberryhrm/presentation/select_employee/view/select_employee.dart';

class AppointmentWithCart extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentWithCart({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "appointment_with".tr(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.r),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () async {
              PhoneBookUser employee = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectEmployeePage(),
                  ));
              if (context.mounted) {
                context
                    .read<AppointmentCreateBloc>()
                    .add(SelectEmployee(context, employee));
              }
            },
            title: Text(
              state?.selectedEmployee?.name! ?? tr("add_a_Substitute"),
              style: TextStyle(fontSize: 16.r),
            ),
            subtitle: Text(
              state?.selectedEmployee?.designation! ?? tr("add_a_Designation"),
              style: TextStyle(fontSize: 14.r),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(state?.selectedEmployee?.avatar ??
                  'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
            ),
            trailing: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}

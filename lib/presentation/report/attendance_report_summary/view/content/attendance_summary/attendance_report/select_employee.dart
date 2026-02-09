import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../select_employee/view/select_employee.dart';
import '../../../../bloc/report_bloc.dart';

class SelectEmployeeForAttendance extends StatelessWidget {
  const SelectEmployeeForAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).r,
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectEmployeePage(),
              )).then((value) {
            if (value != null && context.mounted) {
              context.read<ReportBloc>().add(SelectEmployee(value));
            }
          });
        },
        title: Text(context.watch<ReportBloc>().state.selectEmployee?.name! ??
                'select_employee',style: TextStyle(fontSize: 14.r),).tr(),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(context.watch<ReportBloc>().state.selectEmployee?.avatar ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
        ),
      ),
    );
  }
}

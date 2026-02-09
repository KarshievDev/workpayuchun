import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/select_employee/content/get_employee_content.dart';
import 'package:strawberryhrm/presentation/phonebook/bloc/phonebook_bloc.dart';

class SelectEmployeePage extends StatelessWidget {
  const SelectEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneBookBloc(
          metaClubApiClient: MetaClubApiClient(
              httpService: instance()))
        ..add(PhoneBookLoadRequest()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
          child: AppBar(
            iconTheme: IconThemeData(
                size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
            title: Text(
              'Select Employee',
              style: TextStyle(fontSize: 16.r),
            ),
            backgroundColor: mainColor,
          ),
        ),
        body: const GetEmployeeContent(),
      ),
    );
  }
}

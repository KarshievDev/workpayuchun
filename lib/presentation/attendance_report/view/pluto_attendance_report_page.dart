import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance_report/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/attendance_report/view/content/content.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'pluto_content/pluto_attendance_report_content.dart';

class PlutoAttendanceReportPage extends StatelessWidget {

  final Settings settings;

  const PlutoAttendanceReportPage({super.key, required this.settings});

  static Route route({required Settings settings}) {
    return MaterialPageRoute(builder: (_) => PlutoAttendanceReportPage(settings: settings));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return user != null ? BlocProvider(
            create: (context) => AttendanceReportBloc(user: user, metaClubApiClient: MetaClubApiClient(httpService: instance()))
              ..add(GetAttendanceReportData()),
            child: BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('attendance_report'.tr()),
                    actions: [
                      IconButton(
                          onPressed: () {
                            context.read<AttendanceReportBloc>().add(SelectDatePicker(context));
                          },
                          icon:  Icon(Icons.calendar_month, size: 22.r,))
                    ],
                  ),
                  body: ListView(
                    children: [
                      PlutoAttendanceReportContent(bloc: context.watch<AttendanceReportBloc>(),),
                      AttendanceDailyReportContent(bloc: context.watch<AttendanceReportBloc>(), user: user, settings: settings,),
                    ],
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}

import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';
import 'package:user_repository/user_repository.dart';
import '../view/content/dialog_multi_attendance_list.dart';

part 'attendance_report_event.dart';
part 'attendance_report_state.dart';

class AttendanceReportBloc extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  final MetaClubApiClient metaClubApiClient;
  final LoginData user;
  var dateTime = DateTime.now();
  bool isDialogOpen = true;

  AttendanceReportBloc({required this.metaClubApiClient, required this.user})
      : super(const AttendanceReportState(status: NetworkStatus.initial)) {
    on<GetAttendanceReportData>(_onAttendanceLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<MultiAttendanceEvent>(_onMultiAttendance);
  }

  FutureOr<void> _onMultiAttendance(MultiAttendanceEvent event, Emitter<AttendanceReportState> emit) async {
    try {
      if (isDialogOpen == true) {
        state.copyWith(isDialogOpen: isDialogOpen = false);
        await showDialog(
            barrierDismissible: false,
            context: event.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(event.dailyReport.multipleAttendance?.date ?? "No Date Found"),
                content: DialogMultiAttendanceList(dailyReport: event.dailyReport),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red, fontSize: 12.r),
                    ),
                    onPressed: () {
                      state.copyWith(isDialogOpen: isDialogOpen = true);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } else {
        state.copyWith(isDialogOpen: isDialogOpen = true);
      }
    } on Exception catch (e) {
      emit(const AttendanceReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onAttendanceLoad(GetAttendanceReportData event, Emitter<AttendanceReportState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());

    final data = {'month': event.date ?? currentDate};
    final report = await metaClubApiClient.getAttendanceReport(body: data, userId: user.user!.id);
    report.fold((l) {
      emit(const AttendanceReportState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copyWith(status: NetworkStatus.success, attendanceReport: r));
    });
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<AttendanceReportState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: dateTime,
      locale: const Locale("en"),
    );

    dateTime = date!;
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(GetAttendanceReportData(date: currentMonth));
  }
}

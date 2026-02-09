import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/presentation/home/home.dart';

typedef AttendancePageFactory =
    AttendancePage Function({
      required AttendanceBlocFactory attendanceBlocFactory,
      required AttendanceType attendanceType,
      String? selfie,
    });

class AttendancePage extends StatelessWidget {
  final AttendanceBlocFactory attendanceBlocFactory;
  final AttendanceType attendanceType;
  final String? selfie;

  const AttendancePage({
    super.key,
    required this.attendanceBlocFactory,
    required this.attendanceType,
    this.selfie,
  });

  static Route route({
    AttendanceType attendanceType = AttendanceType.normal,
    String? selfie,
  }) {
    final homeBloc = instance<HomeBlocFactory>();
    final page = instance<AttendancePageFactory>();
    final attendancePage = page(
      attendanceType: attendanceType,
      selfie: selfie,
      attendanceBlocFactory:
          ({required AttendanceType attendanceType, String? selfie}) =>
              AttendanceBloc(
                submitAttendanceUseCase: instance(),
                eventBus: instance(),
                attendanceType: attendanceType,
                selfie: selfie,
                offlineAttendanceRepo: instance(),
                submitRemarksUseCase: instance(),
                logoutUseCase: instance(),
                streamPlaceUseCase: instance(),
                currentLocationUseCase: instance(),
              )..add(
                OnLocationInitEvent(
                  dashboardModel: homeBloc().state.dashboardModel,
                ),
              ),
    );
    return MaterialPageRoute(builder: (_) => attendancePage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: attendanceBlocFactory(
        attendanceType: attendanceType,
        selfie: selfie,
      ),
      child: Scaffold(body: AttendanceView(attendanceType: attendanceType)),
    );
  }
}

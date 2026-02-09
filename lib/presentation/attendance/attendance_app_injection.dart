import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';

class AttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<AttendanceBlocFactory>(
      ({required AttendanceType attendanceType, String? selfie}) => AttendanceBloc(
        submitAttendanceUseCase: instance(),
        attendanceType: attendanceType,
        selfie: selfie,
        eventBus: instance(),
        offlineAttendanceRepo: instance(),
        submitRemarksUseCase: instance(),
        logoutUseCase: instance(),
        streamPlaceUseCase: instance(),
        currentLocationUseCase: instance(),
      ),
    );
    instance.registerFactory<AttendancePageFactory>(
      () =>
          ({
            required AttendanceBlocFactory attendanceBlocFactory,
            required AttendanceType attendanceType,
            String? selfie,
          }) => AttendancePage(
            attendanceBlocFactory: attendanceBlocFactory,
            attendanceType: attendanceType,
            selfie: selfie,
          ),
    );
  }
}

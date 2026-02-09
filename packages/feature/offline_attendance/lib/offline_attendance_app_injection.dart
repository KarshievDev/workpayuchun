import 'package:core/core.dart';
import 'package:hive/hive.dart';
import 'package:offline_attendance/data/offline_attendance_repository_impl.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';

class OfflineAttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<HiveInterface>(Hive);
    instance.registerSingleton<OfflineAttendanceRepository>(
        OfflineAttendanceRepositoryImpl(hive: instance(), directory: instance()));
  }
}

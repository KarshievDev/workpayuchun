import 'package:core/core.dart';

abstract class OfflineAttendanceRepository{

  Future<void> checkInOut({required AttendanceBody checkData,
    required isCheckedIn,
    required isCheckedOut,
    bool multipleAttendanceEnabled = false});

  Future<bool> offlineCheckInOut({required AttendanceBody checkData, required isCheckedIn, required isCheckedOut, bool multipleAttendanceEnabled = false});

  void removeCheckData(int index);

  Future<int> getIndexOfCheckIn({required String date});

  Future<int> getLastIndexOfCheckIn({required String date});

  Future<void>  refreshHiveData({required String date,required AttendanceBody body});

  Future<List<AttendanceBody>> getAllOfflineCheckData();

  Future<List<AttendanceBody>> getAllCheckData();

  Future<Map<String, dynamic>> getAllCheckInOutDataMap();

  Future<Map<String, dynamic>> getPastCheckInOutDataMap({required String today});

  Future<void> deleteFilteredCheckInOut({required String today});

  Future<int> count();

  Future<void> clearCheckData();

  Future<void> clearCheckOfflineData();

  Future<bool> isAlreadyInCheckedIn({required String date});

  Future<bool> isAlreadyInCheckedOut({required String date});

  Future<AttendanceBody?> getCheckDataByDate({String? date});
}
import 'dart:io';
import 'package:core/core.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';

const String checkBoxName = 'checkInOutBox';

class OfflineAttendanceRepositoryImpl implements OfflineAttendanceRepository {
  final HiveInterface hive;
  final Directory directory;

  OfflineAttendanceRepositoryImpl({required this.hive, required this.directory}) {
    hive.registerAdapter(AttendanceBodyAdapter());
  }

  bool isSync = false;

  Future<Box<AttendanceBody>> _openBox() async {
    hive.init(directory.path);
    try {
      final box = await hive.openBox<AttendanceBody>(checkBoxName);
      return box;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> checkInOut({
    required AttendanceBody checkData,
    required isCheckedIn,
    required isCheckedOut,
    bool multipleAttendanceEnabled = false,
  }) async {
    final box = await _openBox();
    if (checkData.attendanceId != null) {
      try {
        box.putAt(0, checkData);
      } catch (_) {
        await clearCheckData();
        await box.add(checkData);
      }
    } else {
      await clearCheckData();
      await box.add(checkData);
    }
    return true;
  }

  @override
  Future<bool> offlineCheckInOut({
    required AttendanceBody checkData,
    required isCheckedIn,
    required isCheckedOut,
    bool multipleAttendanceEnabled = false,
  }) async {
    final box = await _openBox();
    if (isCheckedIn != isCheckedOut) {
      if (checkData.date != null) {
        if (checkData.inTime != null) {
          if (isCheckedOut == false || multipleAttendanceEnabled == false) {
            final index = await getIndexOfCheckIn(date: checkData.date!);
            try {
              box.putAt(index < 0 ? 0 : index, checkData);
            } catch (_) {
              await box.add(checkData);
            }
          } else {
            await box.add(checkData);
          }
        }
      }
    } else {
      if (checkData.inTime != null) {
        await box.add(checkData);
      }
    }
    if (checkData.date != null) {
      await refreshHiveData(date: checkData.date!, body: checkData);
    }
    return true;
  }

  @override
  void removeCheckData(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  @override
  Future<int> getIndexOfCheckIn({required String date}) async {
    final data = await getAllCheckData();
    return data.toList().lastIndexWhere((element) => element.date == date, data.length - 1);
  }

  @override
  Future<int> getLastIndexOfCheckIn({required String date}) async {
    final data = await getAllOfflineCheckData();
    return data.length - 1;
  }

  @override
  refreshHiveData({required String date, required AttendanceBody body}) async {
    final data = await getAllOfflineCheckData();
    final inList = data.where((e) => e.date == date).map((e) => e.inTime).toList();
    final outList = data.where((e) => e.date == date).map((e) => e.outTime).toList();
    final times = [...inList, ...outList].where((e) => e != null).toList();
    final box = await _openBox();
    if (times.length > 6) {
      try {
        // Convert strings to DateTime objects
        List<DateTime> dateTimeList = times.map((time) => DateFormat('h:mm a', 'en').parse(time!)).toList();

        // Find the minimum and maximum times
        DateTime minTime = dateTimeList.reduce((value, element) => value.isBefore(element) ? value : element);
        DateTime maxTime = dateTimeList.reduce((value, element) => value.isAfter(element) ? value : element);

        // Format the times to display
        String formattedMinTime = DateFormat('h:mm a', 'en').format(minTime);
        String formattedMaxTime = DateFormat('h:mm a', 'en').format(maxTime);

        await clearCheckOfflineData();

        box.add(body.copyWith(inTime: formattedMinTime, outTime: formattedMaxTime));
      } catch (_) {}
    }
  }

  @override
  Future<List<AttendanceBody>> getAllOfflineCheckData() async {
    final box = await _openBox();
    return box.values.toList().reversed.where((e) => e.isOffline == true).toList();
  }

  @override
  Future<List<AttendanceBody>> getAllCheckData() async {
    final box = await _openBox();
    return box.values.toList().reversed.map((e) => e).toList();
  }

  @override
  Future<Map<String, dynamic>> getAllCheckInOutDataMap() async {
    final data = await getAllOfflineCheckData();
    return {
      'data':
          data.map((e) {
            Map<String, dynamic> data = {
              'latitude': e.latitude,
              'longitude': e.longitude,
              'date': e.date,
              'inTime': e.inTime,
              'outTime': e.outTime,
              'reason': e.reason ?? "",
              'remote_mode': e.mode,
              'shift_id': e.shiftId,
              'selfie_image': '',
            };
            return data;
          }).toList(),
    };
  }

  ///Return all check in/out data except today's
  @override
  Future<Map<String, dynamic>> getPastCheckInOutDataMap({required String today}) async {
    final data = await getAllOfflineCheckData();
    return {
      'data':
          data.where((e) => e.date != today).map((e) {
            Map<String, dynamic> data = {
              'latitude': e.latitude,
              'longitude': e.longitude,
              'date': e.date,
              'inTime': e.inTime,
              'outTime': e.outTime,
              'reason': e.reason ?? "",
              'remote_mode': e.mode,
              'shift_id': e.shiftId,
              'selfie_image': '',
            };
            return data;
          }).toList(),
    };
  }

  @override
  Future<void> deleteFilteredCheckInOut({required String today}) async {
    final box = await _openBox();
    final keys =
        box.values
            .where((e) => e.isOffline == true && e.date != today)
            .map((e) => box.keyAt(box.values.toList().indexOf(e)))
            .toList();
    if (keys.isNotEmpty) {
      await box.deleteAll(keys);
    }
  }

  @override
  Future<int> count() async {
    final data = await getAllOfflineCheckData();
    return data.length;
  }

  @override
  Future<void> clearCheckOfflineData() async {
    final box = await _openBox();
    final keys =
        box.values.where((e) => e.isOffline == true).map((e) => box.keyAt(box.values.toList().indexOf(e))).toList();
    if (keys.isNotEmpty) {
      await box.deleteAll(keys);
    }
  }

  @override
  Future<void> clearCheckData() async {
    final box = await _openBox();
    await box.clear();
  }

  @override
  Future<bool> isAlreadyInCheckedIn({required String date}) async {
    final data = await getAllCheckData();
    if (data.isNotEmpty) {
      final check = await getCheckDataByDate(date: date);
      if (check?.inTime != null) {
        globalState.set(inTime, check?.inTime);
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> isAlreadyInCheckedOut({required String date}) async {
    final data = await getAllCheckData();
    if (data.isNotEmpty) {
      final check = await getCheckDataByDate(date: date);
      if (check?.outTime != null) {
        globalState.set(inTime, check?.inTime);
        globalState.set(outTime, check?.outTime);
        return true;
      }
    }
    return false;
  }

  @override
  Future<AttendanceBody?> getCheckDataByDate({String? date}) async {
    final data = await getAllCheckData();
    if (data.isNotEmpty) {
      try {
        final attendances = data.firstWhere((element) => element.date == date);
        return attendances;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

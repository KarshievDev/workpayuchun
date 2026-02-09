import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'attendance_body.g.dart';

@HiveType(typeId: 20)
class AttendanceBody extends Equatable {
  @HiveField(0)
  final String? latitude;
  @HiveField(1)
  final String? longitude;
  @HiveField(2)
  final String? reason;
  @HiveField(3)
  final String? date;
  @HiveField(4)
  final String? inTime;
  @HiveField(5)
  final String? outTime;
  @HiveField(6)
  final int? mode;
  @HiveField(7)
  final int? attendanceId;
  @HiveField(8)
  final String? selfieImage;
  @HiveField(9)
  final bool? isOffline;
  @HiveField(10)
  final int? shiftId;

  const AttendanceBody(
      {this.latitude,
      this.longitude,
      this.reason,
      this.date,
      this.inTime,
      this.outTime,
      this.mode,
      this.attendanceId,
      this.selfieImage,
      this.shiftId,
      this.isOffline = true});

  AttendanceBody copyWith(
      {String? latitude,
      String? longitude,
      String? reason,
      String? date,
      String? inTime,
      String? outTime,
      int? mode,
      int? attendanceId,
      int? shiftId,
      String? selfieImage,
      bool? isOffline}) {
    return AttendanceBody(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        reason: reason ?? this.reason,
        date: date ?? this.date,
        inTime: inTime ?? this.inTime,
        outTime: outTime ?? this.outTime,
        mode: mode ?? this.mode,
        attendanceId: attendanceId ?? this.attendanceId,
        shiftId: shiftId ?? this.shiftId,
        selfieImage: selfieImage ?? this.selfieImage,
        isOffline: isOffline ?? this.isOffline);
  }

  Map<String, dynamic> toOfflineJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'date': date,
        'inTime': inTime,
        'outTime': outTime,
        'reason': reason,
        'remote_mode': mode,
        'attendance_id': attendanceId,
        'shift_id': shiftId,
        'selfie_image': selfieImage,
        'isOffline': isOffline,
      };

  Map<String, dynamic> toOnlineJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'reason': reason ?? "",
        'remote_mode': mode,
        'attendance_id': attendanceId,
        'shift_id': shiftId,
        'selfie_image': selfieImage,
      };

  @override
  List<Object?> get props => [inTime, outTime,attendanceId,latitude,longitude,selfieImage];
}

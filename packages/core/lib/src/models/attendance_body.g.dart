// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_body.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceBodyAdapter extends TypeAdapter<AttendanceBody> {
  @override
  final int typeId = 20;

  @override
  AttendanceBody read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceBody(
      latitude: fields[0] as String?,
      longitude: fields[1] as String?,
      reason: fields[2] as String?,
      date: fields[3] as String?,
      inTime: fields[4] as String?,
      outTime: fields[5] as String?,
      mode: fields[6] as int?,
      attendanceId: fields[7] as int?,
      selfieImage: fields[8] as String?,
      shiftId: fields[10] as int?,
      isOffline: fields[9] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceBody obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.reason)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.inTime)
      ..writeByte(5)
      ..write(obj.outTime)
      ..writeByte(6)
      ..write(obj.mode)
      ..writeByte(7)
      ..write(obj.attendanceId)
      ..writeByte(8)
      ..write(obj.selfieImage)
      ..writeByte(9)
      ..write(obj.isOffline)
      ..writeByte(10)
      ..write(obj.shiftId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceBodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

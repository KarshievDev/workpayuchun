// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelAdapter extends TypeAdapter<LocationModel> {
  @override
  final int typeId = 1;

  @override
  LocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModel(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      speed: fields[2] as double?,
      city: fields[4] as String?,
      country: fields[5] as String?,
      address: fields[6] as String?,
      heading: fields[3] as double?,
      distance: fields[8] as double?,
      countryCode: fields[7] as String?,
      datetime: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.speed)
      ..writeByte(3)
      ..write(obj.heading)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.countryCode)
      ..writeByte(8)
      ..write(obj.distance)
      ..writeByte(9)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

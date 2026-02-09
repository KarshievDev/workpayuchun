import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 1)
class LocationModel {
  @HiveField(0)
  double latitude;
  @HiveField(1)
  double longitude;
  @HiveField(2)
  final double? speed;
  @HiveField(3)
  final double? heading;
  @HiveField(4)
  final String? city;
  @HiveField(5)
  final String? country;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? countryCode;
  @HiveField(8)
  double? distance;
  @HiveField(9)
  final String? datetime;

  LocationModel(
      {required this.latitude,
        required this.longitude,
        this.speed,
        this.city,
        this.country,
        this.address,
        this.heading,
        required this.distance,
        this.countryCode,
        this.datetime});

  factory LocationModel.fromJson(Map<dynamic, dynamic> json) {
    return LocationModel(
        longitude: json['longitude'],
        latitude: json['latitude'],
        speed: json['speed'],
        heading: json['heading'],
        city: json['city'],
        country: json['country'],
        address: json['address'],
        distance: json['distance'],
        countryCode: json['countryCode'],
        datetime: json['datetime']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['speed'] = speed;
    data['heading'] = heading;
    data['city'] = city;
    data['country'] = country;
    data['distance'] = distance;
    data['address'] = address;
    data['countryCode'] = countryCode;
    data['datetime'] = datetime;

    return data;
  }

  String getAddress() {
    return '$address $city $country';
  }
}

import 'package:equatable/equatable.dart';

class CheckData extends Equatable{
  final String? message;
  final bool? result;
  final CheckInOut? checkInOut;

  const CheckData({this.message, this.result, this.checkInOut});

  factory CheckData.fromJson(Map<String, dynamic> json) {
    return CheckData(
        result: json['result'],
        message: json['message'],
        checkInOut: json['data'] != null
            ? CheckInOut.fromJson(json['data'])
            : null);
  }
  @override
  List<Object?> get props => [message,result,checkInOut];
}

class CheckInOut extends Equatable {
  final int? id;
  final int? remoteMode;
  final String? date;
  final String? checkIn;
  final String? checkOut;
  final String? inTime;
  final String? outTime;
  final String? stayTime;
  final String? checkInIp;
  final String? latitude;
  final String? longitude;
  final String? inStatus;

  const CheckInOut({this.id,
    this.remoteMode,
    this.date,
    this.checkIn,
    this.checkOut,
    this.inTime,
    this.outTime,
    this.stayTime,
    this.checkInIp,
    this.latitude,
    this.longitude,
    this.inStatus});

  factory CheckInOut.fromJson(Map<String, dynamic> json) {
    return CheckInOut(
        id: json['id'],
        remoteMode: json['remote_mode_in'],
        date: json['date'],
        checkIn: json['check_in'],
        checkOut: json['check_out'],
        stayTime: json['stay_time'],
        inTime: json['in_time'],
        outTime: json['out_time'],
        checkInIp: json['checkin_ip'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        inStatus: json['in_status']);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'remote_mode_in': remoteMode,
        'date': date,
        'check_in': checkIn,
        'checkin_ip': checkInIp,
        'longitude': latitude,
        'latitude': longitude,
        'in_status': inStatus,
      };

  @override
  List<Object?> get props => [id, remoteMode, date,checkIn,checkOut,checkInIp,latitude,longitude,inStatus];
}


class AttendanceFailure extends Equatable{
  final String error;

  const AttendanceFailure({this.error = ''});

  @override
  List<Object?> get props => [error];
}
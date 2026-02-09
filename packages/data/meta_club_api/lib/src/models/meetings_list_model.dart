import 'package:equatable/equatable.dart';

class MeetingsListModel extends Equatable {
  const MeetingsListModel({this.result, this.message, this.data,});

  final bool? result;
  final String? message;
  final MeetingsData? data;

  factory MeetingsListModel.fromJson(Map<String, dynamic> json) => MeetingsListModel(result: json["result"], message: json["message"], data: MeetingsData.fromJson(json["data"]),);

  @override
  List<Object?> get props => [result, message, data];
}

class MeetingsData extends Equatable {
  const MeetingsData({
    this.items,
  });

  final List<MeetingsItem>? items;

  factory MeetingsData.fromJson(Map<String, dynamic> json) => MeetingsData(
        items: List<MeetingsItem>.from(
            json["items"].map((x) => MeetingsItem.fromJson(x))),
      );


  @override
  List<Object?> get props => [items];
}

class MeetingsItem extends Equatable {
  const MeetingsItem(
      {this.id,
      this.title,
      this.date,
      this.day,
      this.time,
      this.startAt,
      this.endAt,
      this.location,
      this.duration,
      this.participants,
      this.appointmentWith});

  final int? id;
  final String? title;
  final String? date;
  final String? day;
  final String? time;
  final String? startAt;
  final String? endAt;
  final String? location;
  final String? duration;
  final List<MeetingsParticipant>? participants;
  final String? appointmentWith;

  factory MeetingsItem.fromJson(Map<String, dynamic> json) => MeetingsItem(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        day: json["day"],
        time: json["time"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        location: json["location"],
        duration: json["duration"],
        participants: List<MeetingsParticipant>.from(
            json["participants"].map((x) => MeetingsParticipant.fromJson(x))),
        appointmentWith: json["appoinmentWith"],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        day,
        time,
        startAt,
        endAt,
        location,
        duration,
        participants
      ];
}

class MeetingsParticipant extends Equatable {
  const MeetingsParticipant({
    this.name,
    this.isAgree,
    this.isPresent,
    this.presentAt,
    this.appointmentStartedAt,
    this.appointmentEndedAt,
    this.appoinmentDuration,
  });

  final String? name;
  final String? isAgree;
  final String? isPresent;
  final String? presentAt;
  final dynamic appointmentStartedAt;
  final dynamic appointmentEndedAt;
  final dynamic appoinmentDuration;

  factory MeetingsParticipant.fromJson(Map<String, dynamic> json) =>
      MeetingsParticipant(
        name: json["name"],
        isAgree: json["is_agree"],
        isPresent: json["is_present"],
        presentAt: json["present_at"],
        appointmentStartedAt: json["appoinment_started_at"],
        appointmentEndedAt: json["appoinment_ended_at"],
        appoinmentDuration: json["appoinment_duration"],
      );

  @override
  List<Object?> get props => [name, isAgree, isPresent, presentAt];
}

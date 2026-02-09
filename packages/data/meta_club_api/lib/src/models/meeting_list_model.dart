import 'package:equatable/equatable.dart';

class MeetingListModel extends Equatable{
  final bool? result;
  final String? message;
  final MeetingList? data;

  const MeetingListModel({
    this.result,
    this.message,
    this.data,
  });

  factory MeetingListModel.fromJson(Map<String, dynamic> json) => MeetingListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : MeetingList.fromJson(json["data"]),
  );

  @override
  List<Object?> get props => [result, message, data];

}

class MeetingList extends Equatable{
  final List<MeetingItem>? items;

  const MeetingList({
    this.items,
  });

  factory MeetingList.fromJson(Map<String, dynamic> json) => MeetingList(
    items: json["items"] == null ? [] : List<MeetingItem>.from(json["items"]!.map((x) => MeetingItem.fromJson(x))),
  );
  @override
  List<Object?> get props => [items];
}

class MeetingItem extends Equatable{
 final int? id;
 final String? title;
 final String? date;
 final String? day;
 final String? time;
 final String? startAt;
 final String? endAt;
 final String? location;
 final String? duration;

  const MeetingItem({
    this.id,
    this.title,
    this.date,
    this.day,
    this.time,
    this.startAt,
    this.endAt,
    this.location,
    this.duration,
  });

  factory MeetingItem.fromJson(Map<String, dynamic> json) => MeetingItem(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    day: json["day"],
    time: json["time"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    location: json["location"],
    duration: json["duration"],
  );
  @override
  List<Object?> get props => [id,title,date,day,time,location,duration];
}

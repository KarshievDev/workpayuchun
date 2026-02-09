import 'package:equatable/equatable.dart';

class ConferenceModel extends Equatable {
  final bool? result;
  final String? message;
  final List<ConferenceData>? data;

  const ConferenceModel({
    this.result,
    this.message,
    this.data,
  });

  factory ConferenceModel.fromJson(Map<String, dynamic> json) =>
      ConferenceModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ConferenceData>.from(
                json["data"]!.map((x) => ConferenceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class ConferenceData extends Equatable {
  final String? title;
  final String? description;
  final DateTime? start;
  final DateTime? end;
  final String? roomId;
  final String? timeText;
  final String? externalLink;
  final String? internalLink;
  final String? button;
  final List<ConferenceMember>? members;

  const ConferenceData(
      {this.title,
        this.description,
      this.start,
      this.end,
      this.roomId,
      this.externalLink,
      this.internalLink,
      this.button,
      this.members,
      this.timeText});

  factory ConferenceData.fromJson(Map<String, dynamic> json) => ConferenceData(
        title: json["title"],
        description: json["description"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        roomId: json["room_id"],
        externalLink: json["external_link"],
        internalLink: json["internal_link"],
        button: json["button"],
        timeText: json["time_text"],
        members: json["members"] == null
            ? []
            : List<ConferenceMember>.from(
                json["members"]!.map((x) => ConferenceMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "room_id": roomId,
        "external_link": externalLink,
        "internal_link": internalLink,
        "button": button,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props =>
      [title, start, end, roomId, externalLink, internalLink, button, members];
}

class ConferenceMember extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;

  const ConferenceMember({
    this.id,
    this.name,
    this.email,
    this.avatar,
  });

  factory ConferenceMember.fromJson(Map<String, dynamic> json) =>
      ConferenceMember(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [id, name, email, avatar];
}

// To parse this JSON data, do
//
//     final electionInfo = electionInfoFromJson(jsonString);

import 'dart:convert';
import 'package:equatable/equatable.dart';

ElectionInfo electionInfoFromJson(String str) =>
    ElectionInfo.fromJson(json.decode(str));

String electionInfoToJson(ElectionInfo data) => json.encode(data.toJson());

class ElectionInfo {
  ElectionInfo({
    this.id,
    this.title,
    this.date,
    this.day,
    this.elections,
  });

  int? id;
  String? title;
  String? date;
  String? day;
  List<Election>? elections;

  factory ElectionInfo.fromJson(Map<String, dynamic> json) => ElectionInfo(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        day: json["day"],
        elections: List<Election>.from(
            json["elections"].map((x) => Election.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "day": day,
        "elections": List<dynamic>.from(elections!.map((x) => x.toJson())),
      };
}

class Election {
  Election({
    this.id,
    this.position,
    this.isVotted,
    this.candidate,
  });

  int? id;
  String? position;
  bool? isVotted;
  List<Candidate>? candidate;

  factory Election.fromJson(Map<String, dynamic> json) => Election(
        id: json["id"],
        position: json["position"],
        isVotted: json["is_votted"],
        candidate: List<Candidate>.from(
            json["candidate"].map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "is_votted": isVotted,
        "candidate": List<dynamic>.from(candidate!.map((x) => x.toJson())),
      };
}

class Candidate extends Equatable {
  const Candidate({
    this.id,
    this.name,
    this.avatar,
  });

  final int? id;
  final String? name;
  final String? avatar;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "avatar": avatar};

  @override
  List<Object?> get props => [id, name, avatar];
}

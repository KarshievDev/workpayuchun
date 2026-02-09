import 'dart:convert';

ResponseQualification responseQualificationFromJson(String str) => ResponseQualification.fromJson(json.decode(str));

String responseQualificationToJson(ResponseQualification data) => json.encode(data.toJson());

class ResponseQualification {
  ResponseQualification({
    this.result,
    required this.data,
  });

  bool? result;
  List<Datum> data;

  factory ResponseQualification.fromJson(Map<String, dynamic> json) => ResponseQualification(
    result: json["result"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.shortName,
  });

  int? id;
  String? name;
  String? shortName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    shortName: json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_name": shortName,
  };
}

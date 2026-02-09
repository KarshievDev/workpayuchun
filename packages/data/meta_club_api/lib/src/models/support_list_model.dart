import 'package:equatable/equatable.dart';

class SupportListModel extends Equatable {
  final bool? result;
  final String? message;
  final SupportData? data;

  const SupportListModel({
    this.result,
    this.message,
    this.data,
  });

  factory SupportListModel.fromJson(Map<String, dynamic> json) =>
      SupportListModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : SupportData.fromJson(json["data"]),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [result, message, data];
}

class SupportData {
  List<SupportModel>? data;

  SupportData({
    this.data,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) => SupportData(
        data: json["data"] == null
            ? []
            : List<SupportModel>.from(
                json["data"]!.map((x) => SupportModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SupportModel {
  int? id;
  String? subject;
  String? file;
  String? typeName;
  String? typeColor;
  String? priorityName;
  String? priorityColor;
  String? date;
  String? description;
  String? imageUrl;

  SupportModel(
      {this.id,
      this.subject,
      this.file,
      this.typeName,
      this.typeColor,
      this.priorityName,
      this.priorityColor,
      this.date,
      this.description,this.imageUrl});

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
      id: json["id"],
      subject: json["subject"],
      file: json["file"],
      typeName: json["type_name"],
      typeColor: json["type_color"],
      imageUrl: json["image_url"],
      priorityName: json["priority_name"],
      priorityColor: json["priority_color"],
      date: json["date"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "file": file,
        "type_name": typeName,
        "type_color": typeColor,
        "priority_name": priorityName,
        "priority_color": priorityColor,
        "date": date,
        "description": description,
    "image_url":imageUrl
      };
}

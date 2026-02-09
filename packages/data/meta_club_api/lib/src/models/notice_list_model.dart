import 'package:equatable/equatable.dart';

class NoticeListModel extends Equatable {
  final bool? result;
  final String? message;
  final NoticeListData? data;

  const NoticeListModel({
    this.result,
    this.message,
    this.data,
  });

  factory NoticeListModel.fromJson(Map<String, dynamic> json) =>
      NoticeListModel(
        result: json["result"],
        message: json["message"],
        data:
            json["data"] == null ? null : NoticeListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class NoticeListData {
 final NoticesList? notices;

  NoticeListData({
    this.notices,
  });

  factory NoticeListData.fromJson(Map<String, dynamic> json) => NoticeListData(
        notices: json["notices"] == null
            ? null
            : NoticesList.fromJson(json["notices"]),
      );

  Map<String, dynamic> toJson() => {
        "notices": notices?.toJson(),
      };
}

class NoticesList {
 final List<NoticeListDatum>? data;

  NoticesList({
    this.data,
  });

  factory NoticesList.fromJson(Map<String, dynamic> json) => NoticesList(
        data: json["data"] == null
            ? []
            : List<NoticeListDatum>.from(
                json["data"]!.map((x) => NoticeListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NoticeListDatum extends Equatable {
  final int? id;
  final String? subject;
  final String? description;
  final String? date;
  final String? file;

  const NoticeListDatum({
    this.id,
    this.subject,
    this.description,
    this.date,
    this.file,
  });

  factory NoticeListDatum.fromJson(Map<String, dynamic> json) =>
      NoticeListDatum(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        date: json["date"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "date": date,
        "file": file,
      };
  @override
  List<Object?> get props => [id, subject, description, date, file];
}

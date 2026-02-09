import 'package:equatable/equatable.dart';

class VisitDetailsModel extends Equatable {
  final VisitDetailsResponse? data;
  final String? env;
  final bool? result;
  final String? message;
  final int? status;

  const VisitDetailsModel({
    this.data,
    this.env,
    this.result,
    this.message,
    this.status,
  });

  factory VisitDetailsModel.fromJson(Map<String, dynamic> json) =>
      VisitDetailsModel(
        data: json["data"] == null
            ? null
            : VisitDetailsResponse.fromJson(json["data"]),
        env: json["env"],
        result: json["result"],
        message: json["message"],
        status: json["status"],
      );

  @override
  List<Object?> get props => [data, env, result, message, status];
}

class VisitDetailsResponse extends Equatable {
  final int? id;
  final String? title;
  final String? date;
  final String? description;
  final String? status;
  final String? statusColor;
  final List<VisitDetailsImage>? images;
  final List<Note>? notes;
  final List<Schedule>? schedules;
  final NextStatus? nextStatus;

  const VisitDetailsResponse({
    this.id,
    this.title,
    this.date,
    this.description,
    this.status,
    this.statusColor,
    this.images,
    this.notes,
    this.schedules,
    this.nextStatus,
  });

  factory VisitDetailsResponse.fromJson(Map<String, dynamic> json) =>
      VisitDetailsResponse(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        description: json["description"],
        status: json["status"],
        statusColor: json["status_color"],
        images: json["images"] == null
            ? []
            : List<VisitDetailsImage>.from(
                json["images"]!.map((x) => VisitDetailsImage.fromJson(x))),
        notes: json["notes"] == null
            ? []
            : List<Note>.from(json["notes"]!.map((x) => Note.fromJson(x))),
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(
                json["schedules"]!.map((x) => Schedule.fromJson(x))),
        nextStatus: json["next_status"] == null
            ? null
            : NextStatus.fromJson(json["next_status"]),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        description,
        status,
        statusColor,
        images,
        notes,
        schedules,
        nextStatus
      ];
}

class VisitDetailsImage extends Equatable {
  final int? id;
  final int? fileId;
  final String? filePath;
  final String? fileUrl;

  const VisitDetailsImage({
    this.id,
    this.fileId,
    this.filePath,
    this.fileUrl
  });

  factory VisitDetailsImage.fromJson(Map<String, dynamic> json) =>
      VisitDetailsImage(
        id: json["id"],
        fileId: json["file_id"],
        filePath: json["file_path"],
        fileUrl: json["file_url"]
      );

  @override
  List<Object?> get props => [id, fileId, filePath,fileUrl];
}

class NextStatus extends Equatable {
  final String? status;
  final String? statusText;

  const NextStatus({
    this.status,
    this.statusText,
  });

  factory NextStatus.fromJson(Map<String, dynamic> json) => NextStatus(
        status: json["status"],
        statusText: json["status_text"],
      );

  @override
  List<Object?> get props => [status, statusText];
}

class Note extends Equatable {
  final String? note;
  final String? status;
  final String? statusColor;
  final String? dateTime;

  const Note({
    this.note,
    this.status,
    this.statusColor,
    this.dateTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        note: json["note"],
        status: json["status"],
        statusColor: json["status_color"],
        dateTime: json["date_time"],
      );

  @override
  List<Object?> get props => [note, status, statusColor, dateTime];
}

class Schedule extends Equatable {
  final String? title;
  final String? latitude;
  final String? longitude;
  final String? note;
  final String? status;
  final String? statusColor;
  final String? dateTime;

  const Schedule({
    this.title,
    this.latitude,
    this.longitude,
    this.note,
    this.status,
    this.statusColor,
    this.dateTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        title: json["title"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        note: json["note"],
        status: json["status"],
        statusColor: json["status_color"],
        dateTime: json["date_time"],
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [title, latitude, longitude, note, status, statusColor, dateTime];
}

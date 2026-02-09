import 'package:equatable/equatable.dart';

class HistoryListModel extends Equatable {
  final bool? result;
  final String? message;
  final HistoryList? data;

  const HistoryListModel({
    this.result,
    this.message,
    this.data,
  });

  factory HistoryListModel.fromJson(Map<String, dynamic> json) =>
      HistoryListModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : HistoryList.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, data];
}

class HistoryList extends Equatable {
  final List<History>? history;

  const HistoryList({
    this.history,
  });

  factory HistoryList.fromJson(Map<String, dynamic> json) => HistoryList(
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
      );

  @override
  List<Object?> get props => [history];
}

class History extends Equatable {
  final int? id;
  final String? title;
  final String? year;
  final String? month;
  final String? day;
  final String? started;
  final String? reached;
  final String? duration;
  final String? status;
  final String? statusColor;

  const History({
    this.id,
    this.title,
    this.year,
    this.month,
    this.day,
    this.started,
    this.reached,
    this.duration,
    this.status,
    this.statusColor,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        started: json["started"],
        reached: json["reached"],
        duration: json["duration"],
        status: json["status"],
        statusColor: json["status_color"],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        year,
        month,
        day,
        started,
        reached,
        duration,
        status,
        statusColor
      ];
}

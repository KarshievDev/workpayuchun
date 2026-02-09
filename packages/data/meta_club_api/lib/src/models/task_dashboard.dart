import 'package:equatable/equatable.dart';

import '../../meta_club_api.dart';

class TaskDashboardModel extends Equatable {
  const TaskDashboardModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final TaskListCollection? data;

  factory TaskDashboardModel.fromJson(Map<String, dynamic> json) =>
      TaskDashboardModel(
        result: json["result"],
        message: json["message"],
        data: TaskListCollection.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, data];
}

class Statistics extends Equatable {
  const Statistics({
    this.count,
    this.text,
    this.status,
    this.image,
  });

  final int? count;
  final String? text;
  final String? status;
  final String? image;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        count: json["count"],
        text: json["text"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "text": text,
        "status": status,
        "image": image,
      };

  @override
  List<Object?> get props => [count, text, status, image];
}

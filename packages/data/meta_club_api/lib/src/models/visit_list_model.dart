import 'package:equatable/equatable.dart';

class VisitListModel extends Equatable{
  final bool? result;
  final String? message;
  final VisitList? visitList;

  const VisitListModel({
    this.result,
    this.message,
    this.visitList,
  });

  factory VisitListModel.fromJson(Map<String, dynamic> json) => VisitListModel(
    result: json["result"],
    message: json["message"],
    visitList: json["data"] == null ? null : VisitList.fromJson(json["data"]),
  );

  @override
  List<Object?> get props => [result, message, visitList];
}

class VisitList extends Equatable{
  final List<MyVisit>? myVisits;

  const VisitList({
    this.myVisits,
  });

  factory VisitList.fromJson(Map<String, dynamic> json) => VisitList(
    myVisits: json["my_visits"] == null ? [] : List<MyVisit>.from(json["my_visits"]!.map((x) => MyVisit.fromJson(x))),
  );

  @override
  List<Object?> get props => [myVisits];
}

class MyVisit extends Equatable{
  final int? id;
  final String? title;
  final String? date;
  final String? status;
  final String? statusColor;

  const MyVisit({
    this.id,
    this.title,
    this.date,
    this.status,
    this.statusColor,
  });

  factory MyVisit.fromJson(Map<String, dynamic> json) => MyVisit(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    status: json["status"],
    statusColor: json["status_color"],
  );

  @override
  List<Object?> get props => [id,title,date,status,statusColor];
}

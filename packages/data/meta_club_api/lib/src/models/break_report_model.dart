import 'package:equatable/equatable.dart';

class BreakReportModel extends Equatable {
  const BreakReportModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final BreakReportData? data;

  factory BreakReportModel.fromJson(Map<String, dynamic> json) =>
      BreakReportModel(
        result: json["result"],
        message: json["message"],
        data: BreakReportData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class BreakReportData extends Equatable {
  const BreakReportData({
    this.totalBreakTime,
    this.hasBreak,
    this.breakHistory,
  });

  final String? totalBreakTime;
  final bool? hasBreak;
  final BreakReportHistory? breakHistory;

  factory BreakReportData.fromJson(Map<String, dynamic> json) =>
      BreakReportData(
        totalBreakTime: json["total_break_time"],
        hasBreak: json["has_break"],
        breakHistory: BreakReportHistory.fromJson(json["break_history"]),
      );

  Map<String, dynamic> toJson() => {
        "total_break_time": totalBreakTime,
        "has_break": hasBreak,
        "break_history": breakHistory!.toJson(),
      };
  @override
  List<Object?> get props => [totalBreakTime, hasBreak, breakHistory];
}

class BreakReportHistory extends Equatable {
  const BreakReportHistory({
    this.todayHistory,
    this.links,
    this.pagination,
  });

  final List<BreakTodayHistory>? todayHistory;
  final Links? links;
  final BreakPagination? pagination;

  factory BreakReportHistory.fromJson(Map<String, dynamic> json) =>
      BreakReportHistory(
        todayHistory: List<BreakTodayHistory>.from(
            json["today_history"].map((x) => BreakTodayHistory.fromJson(x))),
        links: null,
        pagination: null,
      );

  Map<String, dynamic> toJson() => {
        "today_history":
            List<dynamic>.from(todayHistory!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "pagination": pagination!.toJson(),
      };
  @override
  List<Object?> get props => [todayHistory, links, pagination];
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  String? prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class BreakPagination {
  BreakPagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  factory BreakPagination.fromJson(Map<String, dynamic> json) =>
      BreakPagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}

class BreakTodayHistory extends Equatable {
  const BreakTodayHistory({
    this.name,
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  final String? name;
  final String? reason;
  final String? breakTimeDuration;
  final String? breakBackTime;

  factory BreakTodayHistory.fromJson(Map<String, dynamic> json) =>
      BreakTodayHistory(
        name: json["name"],
        reason: json["reason"],
        breakTimeDuration: json["break_time_duration"],
        breakBackTime: json["break_back_time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reason": reason,
        "break_time_duration": breakTimeDuration,
        "break_back_time": breakBackTime,
      };
  @override
  List<Object?> get props => [name, reason, breakTimeDuration, breakBackTime];
}

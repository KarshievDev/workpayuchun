import 'package:equatable/equatable.dart';

class ReportBreakListModel extends Equatable {
  const ReportBreakListModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final ReportBreakListData? data;

  factory ReportBreakListModel.fromJson(Map<String, dynamic> json) =>
      ReportBreakListModel(
        result: json["result"],
        message: json["message"],
        data: ReportBreakListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class ReportBreakListData extends Equatable {
  const ReportBreakListData({
    this.totalBreakTime,
    this.hasBreak,
    this.breakHistory,
  });

  final String? totalBreakTime;
  final bool? hasBreak;
  final ReportBreakListHistory? breakHistory;

  factory ReportBreakListData.fromJson(Map<String, dynamic> json) =>
      ReportBreakListData(
        totalBreakTime: json["total_break_time"],
        hasBreak: json["has_break"],
        breakHistory: ReportBreakListHistory.fromJson(json["break_history"]),
      );

  Map<String, dynamic> toJson() => {
        "total_break_time": totalBreakTime,
        "has_break": hasBreak,
        "break_history": breakHistory?.toJson(),
      };

  @override
  List<Object?> get props => [totalBreakTime, hasBreak, breakHistory];
}

class ReportBreakListHistory {
  ReportBreakListHistory({
    this.todayHistory,
    this.pagination,
  });

  List<BreakReportTodayHistory>? todayHistory;
  BreakReportPagination? pagination;

  factory ReportBreakListHistory.fromJson(Map<String, dynamic> json) =>
      ReportBreakListHistory(
        todayHistory: List<BreakReportTodayHistory>.from(json["today_history"]
            .map((x) => BreakReportTodayHistory.fromJson(x))),
        pagination: BreakReportPagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "today_history":
            List<dynamic>.from(todayHistory!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class BreakReportPagination extends Equatable {
  const BreakReportPagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  final int? total;
  final int? count;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;

  factory BreakReportPagination.fromJson(Map<String, dynamic> json) =>
      BreakReportPagination(
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

  @override
  List<Object?> get props => [total, count, perPage, currentPage, totalPages];
}

class BreakReportTodayHistory extends Equatable {
  const BreakReportTodayHistory({
    this.name,
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  final String? name;
  final String? reason;
  final String? breakTimeDuration;
  final String? breakBackTime;

  factory BreakReportTodayHistory.fromJson(Map<String, dynamic> json) =>
      BreakReportTodayHistory(
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

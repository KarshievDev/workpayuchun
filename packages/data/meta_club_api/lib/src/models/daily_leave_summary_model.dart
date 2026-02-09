import 'package:equatable/equatable.dart';

class DailyLeaveSummaryModel extends Equatable {
  final bool? result;
  final String? message;
  final DailyLeaveSummaryData? dailyLeaveSummaryData;

  const DailyLeaveSummaryModel({
    this.result,
    this.message,
    this.dailyLeaveSummaryData,
  });

  factory DailyLeaveSummaryModel.fromJson(Map<String, dynamic> json) =>
      DailyLeaveSummaryModel(
        result: json["result"],
        message: json["message"],
        dailyLeaveSummaryData: json["data"] == null
            ? null
            : DailyLeaveSummaryData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, dailyLeaveSummaryData];
}

class DailyLeaveSummaryData extends Equatable {
  final Approved? approved;
  final Approved? rejected;
  final Approved? pending;

  const DailyLeaveSummaryData({
    this.approved,
    this.rejected,
    this.pending,
  });

  factory DailyLeaveSummaryData.fromJson(Map<String, dynamic> json) =>
      DailyLeaveSummaryData(
        approved: json["approved"] == null
            ? null
            : Approved.fromJson(json["approved"]),
        rejected: json["rejected"] == null
            ? null
            : Approved.fromJson(json["rejected"]),
        pending:
            json["pending"] == null ? null : Approved.fromJson(json["pending"]),
      );

  @override
  List<Object?> get props => [approved, rejected, pending];
}

class Approved extends Equatable {
  final int? earlyLeave;
  final int? lateArrive;

  const Approved({
    this.earlyLeave,
    this.lateArrive,
  });

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
        earlyLeave: json["early_leave"],
        lateArrive: json["late_arrive"],
      );

  @override
  List<Object?> get props => [earlyLeave, lateArrive];
}

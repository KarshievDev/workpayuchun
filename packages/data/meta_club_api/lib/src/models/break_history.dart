
import 'package:meta_club_api/meta_club_api.dart';

class BreakBackHistory {
  BreakBackHistory({
    this.todayHistory,
  });

  List<TodayBreakItem>? todayHistory;

  factory BreakBackHistory.fromJson(Map<String, dynamic> json) => BreakBackHistory(
    todayHistory: List<TodayBreakItem>.from(json["today_history"].map((x) => TodayBreakItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"today_history": todayHistory!.map((x) => x.toJson()).toList()};
}

class TodayHistory {
  TodayHistory({
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  String? reason;
  String? breakTimeDuration;
  String? breakBackTime;

  factory TodayHistory.fromJson(Map<String, dynamic> json) => TodayHistory(
    reason: json["reason"],
    breakTimeDuration: json["break_time_duration"],
    breakBackTime: json["break_back_time"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "break_time_duration": breakTimeDuration,
    "break_back_time": breakBackTime,
  };
}
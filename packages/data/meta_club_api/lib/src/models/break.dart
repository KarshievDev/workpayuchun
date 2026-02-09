import 'package:equatable/equatable.dart';

class Break extends Equatable {
  const Break({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final BreakItem? data;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
        result: json["result"],
        message: json["message"],
        data: json["result"] != false ? BreakItem.fromJson(json["data"]) : null,
      );

  @override
  List<Object?> get props => [result, message, data];
}

class BreakItem extends Equatable {
  const BreakItem(
      {this.date,
      this.breakTime,
      this.backTime,
      this.reason,
      this.id,
      this.duration,
      this.breakBackHistory,
      this.breakTypeId,
      this.breakTypeName,
      this.isRemark});

  final int? id;
  final int? breakTypeId;
  final DateTime? date;
  final String? breakTypeName;
  final bool? isRemark;
  final String? breakTime;
  final String? backTime;
  final String? reason;
  final String? duration;
  final List<TodayBreakItem>? breakBackHistory;

  factory BreakItem.fromJson(Map<String, dynamic> json) => BreakItem(
        date: json['break']["date"] != null ? DateTime.parse(json['break']["date"]) : null,
        breakTypeId: json['break']["break_type_id"],
        breakTypeName: json['break']["break_type"],
        isRemark: json['break']["is_remark_required"],
        breakTime: json['break']["start_time"],
        backTime: json['break']["end_time"],
        reason: json['break']["reason"],
        breakBackHistory: json["today_history"] != null
            ? List<TodayBreakItem>.from((json['today_history'] as List).map((e) => TodayBreakItem.fromJson(e)))
            : [],
        id: json['break']["id"],
        duration: json['break']["duration"],
      );

  @override
  List<Object?> get props => [id, duration, date, breakTime, backTime];
}

class TodayBreakItem extends Equatable {
  const TodayBreakItem(
      {this.date,
      this.breakTime,
      this.backTime,
      this.reason,
      this.id,
      this.duration,
      this.breakTypeId,
      this.breakTypeName});

  final int? id;
  final int? breakTypeId;
  final String? date;
  final String? breakTypeName;
  final String? breakTime;
  final String? backTime;
  final String? reason;
  final String? duration;

  factory TodayBreakItem.fromJson(Map<String, dynamic> json) => TodayBreakItem(
        date: json["date"],
        breakTypeId: json["break_type_id"],
        breakTypeName: json["break_type"],
        breakTime: json["start_time"],
        backTime: json["end_time"],
        reason: json["reason"],
        id: json["id"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "break_time": breakTime,
        "back_time": backTime,
        "date": date,
        "id": id,
        "duration": duration,
        "break_type_id": breakTypeId,
        "break_type_name": breakTypeName
      };

  @override
  List<Object?> get props => [id, duration, date, breakTime, backTime];
}

class VerifyQRData extends Equatable {
  final List<BreakType> types;

  const VerifyQRData({this.types = const []});

  factory VerifyQRData.fromJson(Map<String, dynamic> json) {
    return VerifyQRData(
        types:
            json['data'] != null ? List<BreakType>.from((json['data'] as List).map((e) => BreakType.fromJson(e))) : []);
  }

  @override
  List<Object?> get props => [types];
}

class BreakType extends Equatable {
  final int? id;
  final String? name;
  final String? icon;
  final bool willAskForMeal;
  final bool remarkRequired;

  const BreakType({this.id, this.name, this.icon, this.willAskForMeal = true, this.remarkRequired = true});

  factory BreakType.fromJson(Map<String, dynamic> json) {
    return BreakType(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        willAskForMeal: json['will_ask_next_meal'],
        remarkRequired: json['is_remark_required']);
  }

  @override
  List<Object?> get props => [id, name];
}

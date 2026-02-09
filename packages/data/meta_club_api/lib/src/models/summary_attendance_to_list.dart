import 'package:equatable/equatable.dart';

class SummaryAttendanceToList extends Equatable {
  const SummaryAttendanceToList({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final SummaryToListData? data;

  factory SummaryAttendanceToList.fromJson(Map<String, dynamic> json) =>
      SummaryAttendanceToList(
        result: json["result"],
        message: json["message"],
        data: json['data'] != null
            ? SummaryToListData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class SummaryToListData extends Equatable {
  const SummaryToListData({
    this.title,
    this.users,
  });

  final String? title;
  final List<SummaryToListUser>? users;

  factory SummaryToListData.fromJson(Map<String, dynamic> json) =>
      SummaryToListData(
        title: json["title"],
        users: List<SummaryToListUser>.from(
            json["users"].map((x) => SummaryToListUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [title, users];
}

class SummaryToListUser extends Equatable {
  const SummaryToListUser({
    this.userId,
    this.name,
    this.designation,
    this.checkIn,
    this.checkOut,
    this.avatar,
  });

  final int? userId;
  final String? name;
  final String? designation;
  final String? checkIn;
  final String? checkOut;
  final String? avatar;

  factory SummaryToListUser.fromJson(Map<String, dynamic> json) =>
      SummaryToListUser(
        userId: json["user_id"],
        name: json["name"],
        designation: json["designation"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "designation": designation,
        "check_in": checkIn,
        "check_out": checkOut,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [
        userId,
        name,
        designation,
        checkIn,
        checkOut,
        avatar,
      ];
}

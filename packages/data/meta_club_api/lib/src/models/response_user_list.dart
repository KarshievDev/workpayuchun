// To parse this JSON data, do
//
//     final responseUserList = responseUserListFromJson(jsonString);

import 'dart:convert';

ResponseUserList responseUserListFromJson(String str) => ResponseUserList.fromJson(json.decode(str));

String responseUserListToJson(ResponseUserList data) => json.encode(data.toJson());

class ResponseUserList {
  ResponseUserList({
    this.result,
    this.data,
  });

  bool? result;
  Data? data;

  factory ResponseUserList.fromJson(Map<String, dynamic> json) => ResponseUserList(
    result: json["result"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.pendingUserList,
    this.rejectedUserList,
  });

  List<UserList>? pendingUserList;
  List<UserList>? rejectedUserList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pendingUserList: List<UserList>.from(json["pending_user_list"].map((x) => UserList.fromJson(x))),
    rejectedUserList: List<UserList>.from(json["rejected_user_list"].map((x) => UserList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pending_user_list": List<dynamic>.from(pendingUserList!.map((x) => x.toJson())),
    "rejected_user_list": List<dynamic>.from(rejectedUserList!.map((x) => x.toJson())),
  };
}

class UserList {
  UserList({
    this.id,
    this.name,
    this.avatar,
    this.phone,
    this.email,
  });

  int? id;
  String? name;
  String? avatar;
  String? phone;
  String? email;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "phone": phone,
    "email": email,
  };
}

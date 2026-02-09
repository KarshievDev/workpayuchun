import 'package:equatable/equatable.dart';

class Phonebook extends Equatable {
  final bool? result;
  final String? message;
  final PhonebookData? data;

  const Phonebook({
    this.result,
    this.message,
    this.data,
  });

  factory Phonebook.fromJson(Map<String, dynamic> json) => Phonebook(
        result: json["result"],
        message: json["message"],
        data:
            json["data"] != null ? PhonebookData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class PhonebookData extends Equatable {
  final List<PhoneBookUser>? users;

  const PhonebookData({
    this.users,
  });

  factory PhonebookData.fromJson(Map<String, dynamic> json) => PhonebookData(
        users: json["users"] != null
            ? List<PhoneBookUser>.from(
                json["users"].map((x) => PhoneBookUser.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [users];
}

class PhoneBookUser extends Equatable {
  const PhoneBookUser({
    this.id,
    this.name,
    this.phone,
    this.designation,
    this.avatar,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? designation;
  final String? avatar;

  factory PhoneBookUser.fromJson(Map<String, dynamic> json) => PhoneBookUser(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        designation: json["designation"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "designation": designation,
        "avatar": avatar,
      };

  @override
  List<Object?> get props => [id, name, phone, designation, avatar];
}

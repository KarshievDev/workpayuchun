import 'package:equatable/equatable.dart';

class PhoneBookDetailsModel extends Equatable {
  const PhoneBookDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final PhonebookDetailsData? data;

  factory PhoneBookDetailsModel.fromJson(Map<String, dynamic> json) =>
      PhoneBookDetailsModel(
        result: json["result"],
        message: json["message"],
        data: PhonebookDetailsData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, data];
}

class PhonebookDetailsData extends Equatable {
  const PhonebookDetailsData({
    this.id,
    this.avatar,
    this.name,
    this.designation,
    this.email,
    this.phone,
    this.department,
    this.birthDate,
    this.bloodGroup,
    this.facebookLink,
    this.linkedinLink,
    this.instagramLink,
    this.appreciates,
  });

  final int? id;
  final String? avatar;
  final String? name;
  final String? designation;
  final String? email;
  final String? phone;
  final String? department;
  final dynamic birthDate;
  final dynamic bloodGroup;
  final dynamic facebookLink;
  final dynamic linkedinLink;
  final dynamic instagramLink;
  final List<dynamic>? appreciates;

  factory PhonebookDetailsData.fromJson(Map<String, dynamic> json) =>
      PhonebookDetailsData(
        id: json['id'],
        avatar: json["avatar"],
        name: json["name"],
        designation: json["designation"],
        email: json["email"],
        phone: json["phone"],
        department: json["department"],
        birthDate: json["birth_date"],
        bloodGroup: json["blood_group"],
        facebookLink: json["facebook_link"],
        linkedinLink: json["linkedin_link"],
        instagramLink: json["instagram_link"],
        appreciates: json["appreciates"] != null
            ? List<dynamic>.from(json["appreciates"].map((x) => x))
            : null,
      );

  @override
  List<Object?> get props => [
        id,
        avatar,
        name,
        designation,
        email,
        phone,
        department,
        birthDate,
        bloodGroup,
        facebookLink,
        linkedinLink,
        instagramLink,
        appreciates
      ];
}

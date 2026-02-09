import 'dart:convert';

GetUserByIdResponse getUserByIdResponseFromJson(String str) =>
    GetUserByIdResponse.fromJson(json.decode(str));

String getUserByIdResponseToJson(GetUserByIdResponse data) =>
    json.encode(data.toJson());

class GetUserByIdResponse {
  GetUserByIdResponse({
    this.result,
    this.data,
  });

  bool? result;
  UserData? data;

  factory GetUserByIdResponse.fromJson(Map<String, dynamic> json) =>
      GetUserByIdResponse(
        result: json["result"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };
}

class UserData {
  UserData({
    this.id,
    this.collegeId,
    this.clubId,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.organization,
    this.mailingAddress,
    this.permanentAddress,
    this.gender,
    this.birthDate,
    this.bloodGroup,
    this.fatherName,
    this.motherName,
    this.nationality,
    this.passportNumber,
    this.religion,
    this.maritalStatus,
    this.anniversary,
    this.designationId,
    this.tin,
    this.bankName,
    this.bankAccount,
    this.emergencyName,
    this.emergencyMobileNumber,
    this.emergencyMobileRelationship,
  });

  int? id;
  int? collegeId;
  int? clubId;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? organization;
  String? mailingAddress;
  String? permanentAddress;
  String? gender;
  String? birthDate;
  String? bloodGroup;
  String? fatherName;
  String? motherName;
  String? nationality;
  String? passportNumber;
  String? religion;
  String? maritalStatus;
  String? anniversary;
  int? designationId;
  String? tin;
  String? bankName;
  String? bankAccount;
  String? emergencyName;
  String? emergencyMobileNumber;
  String? emergencyMobileRelationship;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        collegeId: json["college_id"],
        clubId: json["club_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        organization: json["organization"],
        mailingAddress: json["mailing_address"],
        permanentAddress: json["permanent_address"],
        gender: json["gender"],
        birthDate: json["birth_date"],
        bloodGroup: json["blood_group"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        nationality: json["nationality"],
        passportNumber: json["passport_number"],
        religion: json["religion"],
        maritalStatus: json["marital_status"],
        anniversary: json["anniversary"],
        designationId: json["designation_id"],
        tin: json["tin"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        emergencyName: json["emergency_name"],
        emergencyMobileNumber: json["emergency_mobile_number"],
        emergencyMobileRelationship: json["emergency_mobile_relationship"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "college_id": collegeId,
        "club_id": clubId,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "organization": organization,
        "mailing_address": mailingAddress,
        "permanent_address": permanentAddress,
        "gender": gender,
        "birth_date": birthDate,
        "blood_group": bloodGroup,
        "father_name": fatherName,
        "mother_name": motherName,
        "nationality": nationality,
        "passport_number": passportNumber,
        "religion": religion,
        "marital_status": maritalStatus,
        "anniversary": anniversary,
        "designation_id": designationId,
        "tin": tin,
        "bank_name": bankName,
        "bank_account": bankAccount,
        "emergency_name": emergencyName,
        "emergency_mobile_number": emergencyMobileNumber,
        "emergency_mobile_relationship": emergencyMobileRelationship,
      };
}

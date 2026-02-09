import 'dart:convert';

BodyRegistration bodyRegistrationFromJson(String str) => BodyRegistration.fromJson(json.decode(str));

String bodyRegistrationToJson(BodyRegistration data) => json.encode(data.toJson());

class BodyRegistration {
  BodyRegistration({
    this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    this.phoneCode,
    this.password,
    this.passwordConfirmation,
    required this.qualifications,
    this.dateOfBirth,
    this.occupation,
    this.address,
  });

  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? phoneCode;
  String? password;
  String? passwordConfirmation;
  List<Qualification> qualifications;
  String? dateOfBirth;
  String? occupation;
  String? address;

  factory BodyRegistration.fromJson(Map<String, dynamic> json) => BodyRegistration(
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    phoneCode: json["country_code"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
    qualifications: List<Qualification>.from(json["qualifications"].map((x) => Qualification.fromJson(x))),
    dateOfBirth: json["date_of_birth"],
    occupation: json["occupation"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "phone": phone,
    "country_code": phoneCode,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "qualifications": qualifications.isNotEmpty == true ?  List<dynamic>.from(qualifications.map((x) => x.toJson())) : null,
    "date_of_birth": dateOfBirth,
    "occupation": occupation,
    "address": address,
  };
}

class Qualification {
  Qualification({
    this.qualificationId,
    this.passingYear,
    this.institute,
    this.name
  });

  int? qualificationId;
  String? passingYear;
  String? institute;
  String? name;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
    qualificationId: json["qualification_id"],
    passingYear: json["passing_year"],
    institute: json["institute"],
  );

  Map<String, dynamic> toJson() => {
    "qualification_id": qualificationId,
    "passing_year": passingYear,
    "institute": institute,
  };
}

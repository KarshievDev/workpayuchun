import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final Official? official;
  final Personal? personal;
  final Financial? financial;
  final Emergency? emergency;

  const Profile({this.official, this.personal, this.financial, this.emergency});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      official:
          json['official'] != null ? Official.fromJson(json['official']) : null,
      personal:
          json['personal'] != null ? Personal.fromJson(json['personal']) : null,
      financial: json['financial'] != null
          ? Financial.fromJson(json['financial'])
          : null,
      emergency: json['emergency'] != null
          ? Emergency.fromJson(json['emergency'])
          : null,
    );
  }

  @override
  List<Object?> get props => [official, personal, financial, emergency];
}

class Official extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? avatar;
  final int? departmentId;
  final String? department;
  final int? designationId;
  final String? designation;
  final String? joiningDate;
  final String? employeeType;
  final String? employeeId;

  const Official(
      {this.name,
      this.email,
      this.phone,
      this.address,
      this.avatar,
      this.departmentId,
      this.department,
      this.designationId,
      this.designation,
      this.joiningDate,
      this.employeeType,
      this.employeeId});

  factory Official.fromJson(Map<String, dynamic> json) {
    return Official(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        avatar: json['avatar'],
        departmentId: json['department_id'],
        department: json['department'],
        designation: json['designation'],
        designationId: json['designation_id'],
        joiningDate: json['joining_date'],
        employeeType: json['employee_type'],
        employeeId: json['employee_id']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': phone,
        'avatar': avatar,
        'department_id': address,
        'department': department,
        'designation': designation,
        'designation_id': designationId,
        'joining_date': joiningDate,
        'employee_type': employeeType,
        'employee_id': employeeId
      };

  @override
  List<Object?> get props => [name, email, phone];
}

class Personal extends Equatable {
  final String? department;
  final String? name;
  final String? gender;
  final String? tin;
  final String? avatar;
  final String? phone;
  final String? birthDate;
  final String? address;
  final String? nationality;
  final String? nid;
  final String? passport;
  final String? maritalStatus;
  final String? bloodGroup;

  const Personal(
      {this.department,
      this.name,
      this.gender,
      this.tin,
      this.avatar,
      this.phone,
      this.birthDate,
      this.address,
      this.nationality,
      this.nid,
      this.passport,
      this.maritalStatus,
      this.bloodGroup});

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
        department: json['department'],
        name: json['name'],
        gender: json['gender'],
        tin: json['tin'],
        avatar: json['avatar'],
        phone: json['phone'],
        birthDate: json['birth_date'],
        address: json['address'],
        nationality: json['nationality'],
        nid: json['nid_card_number'],
        passport: json['passport_number'],
        maritalStatus: json['marital_status'],
        bloodGroup: json['blood_group']);
  }

  Map<String, dynamic> toJson() => {
        'department': department,
        'name': name,
        'gender': gender,
        'tin': tin,
        'avatar': avatar,
        'phone': phone,
        'birth_date': birthDate,
        'address': address,
        'nationality': nationality,
        'nid_card_number': nid,
        'passport_number': passport,
        'marital_status': maritalStatus,
        'blood_group': bloodGroup
      };

  @override
  List<Object?> get props => [name, nid, phone, tin];
}

class Financial extends Equatable {
  final String? tin;
  final String? bankName;
  final String? bankAccount;
  final String? avatar;

  const Financial({this.tin, this.bankName, this.bankAccount, this.avatar});

  factory Financial.fromJson(Map<String, dynamic> json) {
    return Financial(
        tin: json['tin'],
        bankAccount: json['bank_account'],
        bankName: json['bank_name'],
        avatar: json['avatar']);
  }

  Map<String, dynamic> toJson() => {
        'tin': tin,
        'bank_account': bankAccount,
        'bank_name': bankName,
        'avatar': avatar
      };

  @override
  List<Object?> get props => [tin, bankAccount, bankName];
}

class Emergency extends Equatable {
  final String? name;
  final String? mobile;
  final String? relationship;
  final String? avatar;

  const Emergency({this.name, this.mobile, this.relationship, this.avatar});

  factory Emergency.fromJson(Map<String, dynamic> json) {
    return Emergency(
        name: json['emergency_name'],
        mobile: json['emergency_mobile_number'],
        relationship: json['emergency_mobile_relationship'],
        avatar: json['avatar']);
  }

  Map<String, dynamic> toJson() => {
        'emergency_name': name,
        'emergency_mobile_number': mobile,
        'emergency_mobile_relationship': relationship,
        'avatar': avatar
      };

  @override
  List<Object?> get props => [name, mobile, relationship];
}

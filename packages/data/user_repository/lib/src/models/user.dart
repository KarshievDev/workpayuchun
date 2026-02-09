import 'package:equatable/equatable.dart';

class LoginData {
  final String? message;
  final User? user;

  LoginData({this.message, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(message: json['message'], user: User.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': user?.toJson()};
  }
}

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? token;
  final bool? isFace;
  final bool? isHr;
  final bool? isAdmin;
  final int? companyId;

  const User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.token,
      this.isFace,
      this.isAdmin,
      this.isHr,
      this.companyId,
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatar: json['avatar'],
        token: json['token'],
        isFace: json['is_face_registered'],
        isHr: json['is_hr'],
        companyId: json['company_id'],
        );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'token': token,
      'is_face_registered': isFace,
      'is_hr': isHr,
      'is_admin': isAdmin,
      'company_id': companyId,
    };
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
      ];
}

class LoginFailure extends Equatable{
  final String error;

  const LoginFailure({this.error = ''});

  @override
  List<Object?> get props => [error];
}

class RegistrationData {
  final bool? result;
  final String? error;

  RegistrationData({this.result, this.error});

  factory RegistrationData.fromJson(Map<String,dynamic> json){
    return RegistrationData(result: json['result'],error: json['error']);
  }

}

class UserModel {
  UserModel({
    this.id,
    this.companyId,
    this.isAdmin,
    this.isHr,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.token,
  });

  int? id;
  int? companyId;
  bool? isAdmin;
  bool? isHr;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String?token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    companyId: int.parse(json["company_id"].toString()),
    isAdmin: json["is_admin"],
    isHr: json["is_hr"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
    token: json["token"],
  );
}


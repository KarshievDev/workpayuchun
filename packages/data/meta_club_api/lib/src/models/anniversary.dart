class AnniversaryModel {
  AnniversaryModel({
    this.data,
    this.env,
    this.result,
    this.message,
    this.status,
  });

  Data? data;
  String? env;
  bool? result;
  String? message;
  int? status;

  factory AnniversaryModel.fromJson(Map<String, dynamic> json) => AnniversaryModel(
    data: Data.fromJson(json["data"]),
    env: json["env"],
    result: json["result"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "env": env,
    "result": result,
    "message": message,
    "status": status,
  };
}

class Data {
  Data({
    this.items,
  });

  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.id,
    this.name,
    this.avatar,
    this.gender,
    this.anniversary,
    this.canWish,
    this.isWished,
    this.message
  });

  int? id;
  String? name;
  String? avatar;
  String? gender;
  String? anniversary;
  bool? canWish;
  bool? isWished;
  String? message;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    gender: json["gender"],
    anniversary: json["anniversary"],
    canWish: json['can_wish'],
    isWished: json["is_wished"],
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "gender": gender,
    "anniversary": anniversary,
    "can_wish" : canWish,
    "is_wished": isWished,
    "message" : message
  };
}

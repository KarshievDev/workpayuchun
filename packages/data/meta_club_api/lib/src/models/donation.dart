class DonationModel {
  DonationModel({
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

  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
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
    this.title,
    this.description,
    this.date,
    this.day,
    this.startDate,
    this.endDate,
    this.attachmentFile,
    this.donors,
    this.appreciate,
    this.totalAmount,
  });

  int? id;
  String? title;
  String? description;
  String? date;
  String? day;
  String? startDate;
  String? endDate;
  String? attachmentFile;
  int? donors;
  int? appreciate;
  int? totalAmount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: json["date"],
    day: json["day"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    attachmentFile: json["attachment_file"],
    donors: json["doners"],
    appreciate: json["appreciate"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date,
    "day": day,
    "start_date": startDate,
    "end_date": endDate,
    "attachment_file": attachmentFile,
    "doners": donors,
    "appreciate": appreciate,
    "total_amount": totalAmount,
  };
}

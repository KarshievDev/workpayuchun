class ActsRegulationModel {
  ActsRegulationModel({
    this.result,
    this.data,
  });

  bool? result;
  Data? data;

  factory ActsRegulationModel.fromJson(Map<String, dynamic> json) => ActsRegulationModel(
    result: json["result"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.title,
    this.slug,
    this.content,
  });

  String? title;
  String? slug;
  String? content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "slug": slug,
    "content": content,
  };
}

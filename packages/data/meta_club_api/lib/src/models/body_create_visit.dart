class BodyCreateVisit{
  String? date;
  String? title;
  String? description;
  int? userId;

  BodyCreateVisit({
    this.date,
    this.title,
    this.description,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
    "date": date,
    "title": title,
    "description": description,
    "user_id": userId,
  };
}

class BodyUpdateVisit {
  int? id;
  String? title;
  String? description;

  BodyUpdateVisit({this.id, this.title, this.description});

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "description": description};
}

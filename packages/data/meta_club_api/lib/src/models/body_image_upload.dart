class BodyImageUpload {
  int? id;
  String? imageURL;

  BodyImageUpload({this.id, this.imageURL});

  Map<String, dynamic> toJson() => {"id": id, "visit_image": imageURL};
}

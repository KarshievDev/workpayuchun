class Content {
  final int? id;
  final String? title;
  final String? slug;

  Content({this.id, this.title, this.slug});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(title: json['title'], slug: json['content']);
  }
}

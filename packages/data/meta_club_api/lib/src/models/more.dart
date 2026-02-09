class More {
  final int? id;
  final String? title;
  final String? slug;
  final String? content;

  More({this.id, this.title, this.slug,this.content});

  factory More.fromJson(Map<String, dynamic> json) {
    return More(id: json['id'], title: json['title'], slug: json['slug'],content: json['content']);
  }
}


class Mores {

  List<More> mores;

  Mores({required this.mores});

  factory Mores.fromJson(Map<String,dynamic> json){
    return Mores(mores:  (json['data'] as List)
        .map((e) => More.fromJson(e))
        .toList());
  }

}
class Galleries {
  List<Gallery> galleries;

  Galleries({required this.galleries});

  factory Galleries.fromJson(Map<String, dynamic> json) {
    return Galleries(galleries: (json['data']['items'] as List).map((e) => Gallery.fromJson(e)).toList());
  }
}

class Gallery {
  final int? id;
  final String? attachmentFile;

  Gallery(
      {this.id,
        this.attachmentFile});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
        id: json['id'],
        attachmentFile: json['attachment_file']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attachment_file': attachmentFile,
    };
  }
}

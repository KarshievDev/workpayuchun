class Notices {
  List<Notice> notices;

  Notices({required this.notices});

  factory Notices.fromJson(Map<String, dynamic> json) {
    return Notices(
        notices: (json['data']['items'] as List)
            .map((e) => Notice.fromJson(e))
            .toList());
  }
}

class Notice {
  final int? id;
  final String? subject;
  final String? date;
  final String? description;
  final String? image;
  final String? createdBy;

  Notice(
      {this.id,
      this.subject,
      this.date,
      this.description,
      this.image,
      this.createdBy});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
        id: json['id'],
        subject: json['subject'],
        date: json['date'],
        description: json['description'],
        image: json['attachment_file'],
        createdBy: json['created_by']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'date': date,
      'description': description,
      'attachment_file': image,
      'created_by': createdBy,
    };
  }
}

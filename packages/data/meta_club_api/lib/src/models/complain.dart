class ComplainData {
  final List<Complain> complains;

  ComplainData({this.complains = const []});

  factory ComplainData.fromJson(Map<String, dynamic> json) {
    return ComplainData(complains: List<Complain>.from((json['data'] as List).map((e) => Complain.fromJson(e))));
  }
}

class Complain {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? deadline;
  final String? attachment;
  final String? status;
  final ComplainCreator? creator;

  Complain(
      {this.id, this.title, this.description, this.date, this.deadline, this.attachment, this.status, this.creator});

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
        deadline: json['response_deadline'],
        attachment: json['attachment'],
        status: json['status'],
        creator: json['creator'] != null ? ComplainCreator.fromJson(json['creator']) : null);
  }
}

class ComplainCreator {
  final int? id;
  final String? name;
  final String? department;
  final String? designation;
  final String? avatar;

  ComplainCreator({this.id, this.name, this.department, this.designation, this.avatar});

  factory ComplainCreator.fromJson(Map<String, dynamic> json) {
    return ComplainCreator(
        id: json['id'],
        name: json['name'],
        department: json['department'],
        designation: json['designation'],
        avatar: json['avatar']);
  }
}

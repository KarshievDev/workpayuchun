class ComplainBody {
  final String? title;
  final String? date;
  final String? deadline;
  final int? employeeId;
  final String? description;
  final String? attachment;

  ComplainBody({this.title, this.date, this.deadline, this.employeeId, this.description, this.attachment});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['date'] = date;
    map['response_deadline'] = deadline;
    map['user_id'] = employeeId;
    map["description"] = description;
    map["attachment"] = attachment;
    return map;
  }
}

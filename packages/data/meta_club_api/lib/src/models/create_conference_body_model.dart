class CreateConferenceBodyModel {
  String? title;
  String? description;
  String? date;
  String? startAt;
  String? endAt;
  String? participants;

  CreateConferenceBodyModel(
      {this.title,
      this.description,
      this.date,
      this.startAt,
      this.endAt,
      this.participants});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['content'] = description;
    map['date'] = date;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['user_id'] = participants;
    return map;
  }
}

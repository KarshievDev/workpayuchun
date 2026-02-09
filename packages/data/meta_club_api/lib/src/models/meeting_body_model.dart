class MeetingBodyModel {
  String? title;
  String? description;
  String? location;
  String? date;
  String? attachmentFile;
  String? participants;
  String? duration;
  String? startAt;
  String? endAt;

  MeetingBodyModel(
      {this.title,
      this.description,
      this.location,
      this.date,
      this.attachmentFile,
      this.participants,
      this.duration,
      this.startAt,
      this.endAt});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['location'] = location;
    map['date'] = date;
    map['image_url'] = attachmentFile;
    map['participants'] = participants;
    map['duration'] = duration;
    map['start_at'] = startAt;
    map['end_at'] = endAt;

    return map;
  }
}

class BodyCreateSchedule {
  int? visitId;
  String? date;
  String? latitude;
  String? longitude;
  String? note;

  BodyCreateSchedule(
      {this.visitId, this.date, this.latitude, this.longitude, this.note});

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
        "date": date,
        "latitude": latitude,
        "longitude": longitude,
        "note": note
      };
}

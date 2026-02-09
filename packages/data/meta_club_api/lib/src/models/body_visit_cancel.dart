class BodyVisitCancel{
  int? visitId;
  String? status;
  String? latitude;
  String? longitude;
  String? cancelNote;

  BodyVisitCancel({
    this.visitId,
    this.status,
    this.latitude,
    this.longitude,
    this.cancelNote
  });

  Map<String, dynamic> toJson() => {
    "visit_id": visitId,
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
    "cancel_note": cancelNote
  };
}
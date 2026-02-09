class BodyVisitNote{
  String? note;
  int? visitId;

  BodyVisitNote({
    this.note,
    this.visitId
});

  Map<String,dynamic> toJson() => {
    "note" : note,
    "visit_id": visitId
  };
}
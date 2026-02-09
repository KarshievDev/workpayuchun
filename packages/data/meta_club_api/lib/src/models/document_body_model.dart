class DocumentBody {
  String? description;
  String? date;
  String? fileLink;
  int? informedTo;
  int? documentTypeId;

  DocumentBody({this.description, this.date, this.fileLink, this.informedTo, this.documentTypeId});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['document_type_id'] = documentTypeId;
    map['request_application'] = description;
    map['informed_to'] = informedTo;
    map['request_date'] = date;
    map["file"] = fileLink;
    return map;
  }
}

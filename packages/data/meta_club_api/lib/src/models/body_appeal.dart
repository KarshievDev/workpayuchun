class BodyAppeal {
  final String? appealDetails;

  BodyAppeal({this.appealDetails});

  Map<String, dynamic> toJson(){
    var map = <String, dynamic>{};
    map["appeal_details"] = appealDetails;
    return map;
  }
}
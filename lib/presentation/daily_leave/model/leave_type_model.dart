class LeaveTypeModel {
  String? title;
  String? value;

  LeaveTypeModel({this.title, this.value});

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}
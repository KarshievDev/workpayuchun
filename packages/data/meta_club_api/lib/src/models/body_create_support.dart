import 'package:equatable/equatable.dart';

class BodyCreateSupport {
  String? subject;
  String? description;
  int? priorityId;
  String? previewId;

  BodyCreateSupport({String? subject, String? description, int? priority,String? previewId}) {
    subject = this.subject;
    description = this.description;
    priority = priorityId;
    previewId = this.previewId;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subject"] = subject;
    map["description"] = description;
    map["priority_id"] = priorityId;
    map["image_url"] = previewId;

    return map;
  }
}

class BodyPrioritySupport extends Equatable{
  final int? priorityId;
  final String? priorityName;

  const BodyPrioritySupport({this.priorityName, this.priorityId});

  Map<String, dynamic> toJson(){
    var map = <String, dynamic>{};
    map["priority_id"] = priorityId;
    map["priority_name"] = priorityName;
    return map;
  }

  @override
  List<Object?> get props => [priorityId,priorityName];
}

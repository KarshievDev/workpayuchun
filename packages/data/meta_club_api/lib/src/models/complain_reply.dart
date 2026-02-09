import 'package:meta_club_api/meta_club_api.dart';

class ComplainReply {
  final int? id;
  final int? isHRContact;
  final String? description;
  final ComplainCreator? complainCreator;

  ComplainReply({this.id, this.isHRContact, this.description, this.complainCreator});

  factory ComplainReply.fromJson(Map<String, dynamic> json) {
    return ComplainReply(
        id: json['id'],
        isHRContact: json['is_hr_contact'],
        description: json['description'],
        complainCreator: json['user'] != null ? ComplainCreator.fromJson(json['user']) : null);
  }
}

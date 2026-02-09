import 'package:equatable/equatable.dart';

class TravelCategory extends Equatable {
  final int? id;
  final String? name;

  const TravelCategory({this.id, this.name});

  factory TravelCategory.fromJson(Map<String, dynamic> json) {
    return TravelCategory(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [id, name];
}

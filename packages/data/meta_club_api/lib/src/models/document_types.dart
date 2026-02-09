import 'package:equatable/equatable.dart';

class DocumentType {
  final int? id;
  final String? name;
  final String? requestTemplate;

  DocumentType({this.id, this.name, this.requestTemplate});

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(id: json['id'], name: json['name'], requestTemplate: json['request_template']);
  }
}

class DocumentTypes extends Equatable {
  final List<DocumentType> types;

  const DocumentTypes({this.types = const []});

  factory DocumentTypes.fromJson(Map<String, dynamic> json) {
    return DocumentTypes(
        types: json['data'] != null
            ? List<DocumentType>.from((json['data'] as List).map((e) => DocumentType.fromJson(e)))
            : []);
  }

  @override
  List<Object?> get props => [types];
}

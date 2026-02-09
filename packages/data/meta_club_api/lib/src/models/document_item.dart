import 'package:equatable/equatable.dart';

class DocumentItem {
  final int? id;
  final String? date;
  final int? userId;
  final int? docTypeId;
  final String? docTypeName;
  final String? description;
  final String? requestFile;
  final String? responseFile;
  final String? responseFileExpireDate;
  final String? responseStatus;
  final DocumentInform? documentInform;

  DocumentItem(
      {this.id,
      this.date,
      this.userId,
      this.docTypeId,
      this.docTypeName,
      this.description,
      this.requestFile,
      this.responseFile,
      this.responseFileExpireDate,
      this.responseStatus,
      this.documentInform});

  factory DocumentItem.fromJson(Map<String, dynamic> json) {
    return DocumentItem(
      id: json['id'],
      date: json['date'],
      userId: json['user_id'],
      docTypeId: json['user_document_type_id'],
      docTypeName: json['document_type'],
      description: json['request_description'],
      requestFile: json['request_file'],
      responseFile: json['response_file'],
      responseFileExpireDate: json['response_file_expire_date'],
      responseStatus: json['response_status'],
      documentInform: json['informed_to'] != null ? DocumentInform.fromJson(json['informed_to']) : null,
    );
  }
}

class DocumentInform extends Equatable {
  final String? name;
  final String? employeeId;
  final String? department;
  final String? designation;

  const DocumentInform({this.name, this.employeeId, this.department, this.designation});

  factory DocumentInform.fromJson(Map<String, dynamic> json) {
    return DocumentInform(
        name: json['name'],
        employeeId: json['employee_id'],
        department: json['department'],
        designation: json['designation']);
  }

  @override
  List<Object?> get props => [name, employeeId, department, designation];
}

class DocumentItems extends Equatable {
  final List<DocumentItem> items;

  const DocumentItems({this.items = const []});

  factory DocumentItems.fromJson(Map<String, dynamic> json) {
    return DocumentItems(
        items: json['data']['data'] != null
            ? List<DocumentItem>.from((json['data']['data'] as List).map((e) => DocumentItem.fromJson(e)))
            : []);
  }

  @override
  List<Object?> get props => [items];
}

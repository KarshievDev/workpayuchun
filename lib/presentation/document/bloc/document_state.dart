part of 'document_bloc.dart';

class DocumentState extends Equatable {
  final NetworkStatus? status;
  final String? date;
  final String? reason;
  final String? documentPath;
  final DocumentType? docType;
  final DocumentTypes? documentTypes;
  final DocumentItems? documentItems;
  final PhoneBookUser? selectedEmployee;

  const DocumentState(
      {this.status,
      this.date,
      this.selectedEmployee,
      this.docType,
      this.documentTypes,
      this.reason,
      this.documentItems,
      this.documentPath});

  DocumentState copy(
      {NetworkStatus? status,
      String? date,
      DocumentType? docType,
      DocumentTypes? documentTypes,
      DocumentItems? documentItems,
      String? reason,
      String? documentPath,
      PhoneBookUser? selectedEmployee}) {
    return DocumentState(
        status: status ?? this.status,
        date: date ?? this.date,
        docType: docType ?? this.docType,
        reason: reason ?? this.reason,
        documentItems: documentItems ?? this.documentItems,
        documentTypes: documentTypes ?? this.documentTypes,
        documentPath: documentPath ?? this.documentPath,
        selectedEmployee: selectedEmployee ?? this.selectedEmployee);
  }

  @override
  List<Object?> get props => [status, date, selectedEmployee, docType, documentItems, documentTypes];
}

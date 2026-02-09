part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDocumentData extends DocumentEvent {
  final int? statusCode;

  GetDocumentData({this.statusCode});

  @override
  List<Object> get props => [];
}

class GetDocumentTypeData extends DocumentEvent {
  GetDocumentTypeData();

  @override
  List<Object> get props => [];
}

class OnSelectDate extends DocumentEvent {
  final String? date;

  OnSelectDate({this.date});

  @override
  List<Object> get props => [];
}

class OnSelectImage extends DocumentEvent {
  final String? document;

  OnSelectImage({this.document});

  @override
  List<Object> get props => [];
}

class OnSelectDocType extends DocumentEvent {
  final DocumentType? type;

  OnSelectDocType(
    this.type,
  );

  @override
  List<Object> get props => [];
}

class SubmitButton extends DocumentEvent {
  final BuildContext context;

  SubmitButton({required this.context});

  @override
  List<Object> get props => [context];
}

class SelectDateTime extends DocumentEvent {
  final BuildContext context;
  final String date;

  SelectDateTime(this.context, this.date);

  @override
  List<Object> get props => [context, date];
}

class OnSelectEmployee extends DocumentEvent {
  final PhoneBookUser? selectEmployee;

  OnSelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [];
}

class OnReasonUpdated extends DocumentEvent {
  final String? reason;

  OnReasonUpdated({this.reason});

  @override
  List<Object> get props => [];
}

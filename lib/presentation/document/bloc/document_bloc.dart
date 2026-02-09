import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'document_event.dart';

part 'document_state.dart';

typedef DocumentBlocFactory = DocumentBloc Function();

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final LoadDocumentRequestTypes loadDocumentRequestTypes;
  final LoadDocumentRequest loadDocumentRequest;
  final SubmitDocumentRequest submitDocumentRequest;
  final TextEditingController controller = TextEditingController();

  DocumentBloc(
      {required this.loadDocumentRequest, required this.loadDocumentRequestTypes, required this.submitDocumentRequest})
      : super(const DocumentState(status: NetworkStatus.initial)) {
    on<GetDocumentData>(_onDocumentLoad);
    on<GetDocumentTypeData>(_onDocumentTypesLoad);
    on<OnSelectDocType>(_documentTypeChanged);
    on<OnSelectDate>(_onSelectDate);
    on<OnSelectEmployee>(_onSelectEmployee);
    on<OnSelectImage>(_onDocumentUploaded);
    on<OnReasonUpdated>(_onDocumentReasonUpdate);
    on<SubmitButton>(_onDocumentSubmit);
  }

  void _onDocumentLoad(GetDocumentData event, Emitter<DocumentState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    final data = await loadDocumentRequest();
    data.fold((l) {
      emit(state.copy(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copy(status: NetworkStatus.success, documentItems: r));
    });
  }

  void _onDocumentTypesLoad(GetDocumentTypeData event, Emitter<DocumentState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    final data = await loadDocumentRequestTypes();
    data.fold((l) {
      emit(const DocumentState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copy(status: NetworkStatus.success, documentTypes: r));
    });
  }

  void _documentTypeChanged(OnSelectDocType event, Emitter<DocumentState> emit) {
    emit(state.copy(docType: event.type));
  }

  void _onSelectDate(OnSelectDate event, Emitter<DocumentState> emit) async {
    emit(state.copy(date: event.date));
  }

  void _onSelectEmployee(OnSelectEmployee event, Emitter<DocumentState> emit) async {
    emit(state.copy(selectedEmployee: event.selectEmployee));
  }

  void _onDocumentUploaded(OnSelectImage event, Emitter<DocumentState> emit) async {
    emit(state.copy(documentPath: event.document));
  }

  void _onDocumentReasonUpdate(OnReasonUpdated event, Emitter<DocumentState> emit) async {
    emit(state.copy(reason: event.reason));
  }

  void _onDocumentSubmit(SubmitButton event, Emitter<DocumentState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    final body = DocumentBody(
        documentTypeId: state.docType?.id,
        date: state.date,
        fileLink: state.documentPath,
        informedTo: state.selectedEmployee?.id,
        description: controller.text);
    final data = await submitDocumentRequest(body: body);
    data.fold((l) {
      emit(state.copy(status: NetworkStatus.failure));
    }, (r) {
      Navigator.pop(event.context);
      add(GetDocumentData());
    });
  }
}

import 'package:core/core.dart';
import 'bloc/document_bloc.dart';

class DocumentAppInjection {
  Future<void> initInjection() async {
    instance.registerFactory<DocumentBlocFactory>(() => () => DocumentBloc(
        loadDocumentRequest: instance(), loadDocumentRequestTypes: instance(), submitDocumentRequest: instance()));
  }
}

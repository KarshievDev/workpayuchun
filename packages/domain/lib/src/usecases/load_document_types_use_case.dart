import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadDocumentRequestTypes extends BaseUseCase<DocumentTypes> {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadDocumentRequestTypes({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, DocumentTypes>> call() {
    return hrmCoreBaseService.documentTypes();
  }
}

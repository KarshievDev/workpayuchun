import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadDocumentRequest{

  final HRMCoreBaseService hrmCoreBaseService;


  LoadDocumentRequest({required this.hrmCoreBaseService});

  Future<Either<Failure, DocumentItems>> call({int? statusCode}) async {
    return hrmCoreBaseService.documentItems(statusCode: statusCode);
  }
}

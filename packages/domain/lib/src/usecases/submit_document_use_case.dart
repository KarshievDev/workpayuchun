import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitDocumentRequest {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitDocumentRequest({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required DocumentBody body}) async {
    return await hrmCoreBaseService.submitDocumentRequest(body: body);
  }
}

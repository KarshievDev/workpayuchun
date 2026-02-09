import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitComplainReplyUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitComplainReplyUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required ComplainReplyBody body, required int complainId}) async {
    return hrmCoreBaseService.submitComplainReply(body: body, complainId: complainId);
  }
}

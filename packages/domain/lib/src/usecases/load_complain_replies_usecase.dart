import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadComplainRepliesUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadComplainRepliesUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, List<ComplainReply>>> call({required int complainId}) async {
    return hrmCoreBaseService.complainReplies(complainId: complainId);
  }
}

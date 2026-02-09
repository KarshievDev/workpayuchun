import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadLeaveSummeryDataUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadLeaveSummeryDataUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, LeaveSummaryModel?>> call({required int uid}) async {
    return await hrmCoreBaseService.leaveSummaryApi(uid);
  }
}

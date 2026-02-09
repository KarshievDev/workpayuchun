import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitDailyReportUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitDailyReportUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required SubmitDailyReportBody body}) async {
    return await hrmCoreBaseService.submitDailyReport(body: body);
  }
}
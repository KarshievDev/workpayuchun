import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadDailyReportUseCase extends BaseUseCase<DailyReportListModel?> {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadDailyReportUseCase({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, DailyReportListModel?>> call() {
    return hrmCoreBaseService.getDailyReports();
  }
}

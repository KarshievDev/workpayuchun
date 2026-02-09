import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class BreakBackHistoryUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  BreakBackHistoryUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, BreakReportModel?>> call({required String date}) async {
    return await hrmCoreBaseService.getBreakHistory(date);
  }
}

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitDeductionAppealUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitDeductionAppealUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required BodyAppeal body, required deductionID}) {
    return hrmCoreBaseService.submitDeductionAppeal(body: body, deductionID: deductionID);
  }
}

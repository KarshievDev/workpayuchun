import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadDeductionUseCase extends BaseUseCase<DeductionData?> {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadDeductionUseCase({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, DeductionData?>> call() {
    return hrmCoreBaseService.getDeductionData();
  }
}

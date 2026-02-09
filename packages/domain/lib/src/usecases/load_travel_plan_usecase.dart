import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadTravelPlanUseCase extends BaseUseCase<TravelPlanModel?> {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadTravelPlanUseCase({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, TravelPlanModel?>> call() {
    return hrmCoreBaseService.getTravelPlans();
  }
}

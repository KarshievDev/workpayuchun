import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitTravelPlanUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitTravelPlanUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required TravelPlanBody body}) async {
    return await hrmCoreBaseService.submitTravelPlanRequest(body: body);
  }
}
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadTravelExpenseUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadTravelExpenseUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, TravelExpense?>> call({required int travelPlanId}) {
    return hrmCoreBaseService.getTravelPlanExpenses(travelPlanId: travelPlanId);
  }
}

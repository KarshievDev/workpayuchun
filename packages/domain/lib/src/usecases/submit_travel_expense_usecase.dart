import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitTravelExpenseUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitTravelExpenseUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required TravelPlanExpenseBody body}) async {
    return await hrmCoreBaseService.submitTravelPlanExpense(body: body);
  }
}

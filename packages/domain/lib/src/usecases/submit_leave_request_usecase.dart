import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitLeaveRequestUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitLeaveRequestUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required BodyCreateLeaveModel body}) async {
    return await hrmCoreBaseService.submitLeaveRequestApi(bodyCreateLeaveModel: body);
  }
}

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadLeaveRequestTypeUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadLeaveRequestTypeUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, LeaveRequestTypeModel>> call({required int uid}) async {
    return await hrmCoreBaseService.leaveRequestTypeApi(uid);
  }
}

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadLeaveRequestDataUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadLeaveRequestDataUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, LeaveRequestModel?>> call({required int uid, required String cMonth}) async {
    return await hrmCoreBaseService.leaveRequestApi(uid, cMonth);
  }
}

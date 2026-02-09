import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadLeaveDetailsDataUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadLeaveDetailsDataUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, LeaveDetailsModel?>> call({required int uid, required int rid}) async {
    return await hrmCoreBaseService.leaveDetailsApi(uid, rid);
  }
}

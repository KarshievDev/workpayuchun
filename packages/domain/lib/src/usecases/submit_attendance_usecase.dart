import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitAttendanceUseCase{
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitAttendanceUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure,CheckData?>> call({required AttendanceBody body}) async {
    final checkInOutDataModel = body.toOnlineJson();
    return await hrmCoreBaseService.checkInOut(body: checkInOutDataModel);
  }
}
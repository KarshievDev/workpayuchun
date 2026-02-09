import 'package:meta_club_api/meta_club_api.dart';

class LeaveCancelRequestUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LeaveCancelRequestUseCase({required this.hrmCoreBaseService});

  Future<bool> call({required int rid}) async {
    return await hrmCoreBaseService.cancelLeaveRequest(rid);
  }
}

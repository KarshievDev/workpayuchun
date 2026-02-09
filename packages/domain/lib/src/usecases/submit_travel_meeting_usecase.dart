import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitTravelMeetingUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitTravelMeetingUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required CreateTravelMeetingBody body}) async {
    return await hrmCoreBaseService.submitTravelMeeting(body: body);
  }
}
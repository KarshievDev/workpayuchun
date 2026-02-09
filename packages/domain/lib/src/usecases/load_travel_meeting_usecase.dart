import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadTravelMeetingUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadTravelMeetingUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, TravelMeetingModel?>> call({required int travelPlanId}) {
    return hrmCoreBaseService.getTravelMeeting(travelPlanId: travelPlanId);
  }

}
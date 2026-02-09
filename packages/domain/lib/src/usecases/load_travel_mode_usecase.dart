import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadTravelModeUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadTravelModeUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, List<String>>> call() {
    return hrmCoreBaseService.travelModes();
  }
}

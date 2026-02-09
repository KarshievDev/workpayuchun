import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadComplainUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadComplainUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, ComplainData>> call({String? date, bool complain = true}) async {
    return hrmCoreBaseService.getComplains(date: date,complain: complain);
  }
}

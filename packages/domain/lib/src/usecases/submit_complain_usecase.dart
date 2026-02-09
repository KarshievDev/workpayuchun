import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitComplainUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitComplainUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required ComplainBody body, bool complain = true}) async {
    return hrmCoreBaseService.submitComplain(body: body, complain: complain);
  }
}

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SubmitRemarksUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SubmitRemarksUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required StoreRemarksBody body}) async {
    return hrmCoreBaseService.storeRemarks(body: body);
  }
}

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class BreakBackQRVerifyUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  BreakBackQRVerifyUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, VerifyQRData>> call({required String code}) async {
    return hrmCoreBaseService.verifyQR(code: code);
  }
}

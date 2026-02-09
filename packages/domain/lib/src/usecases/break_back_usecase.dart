import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class BreakBackUseCase{
  final HRMCoreBaseService hrmCoreBaseService;

  BreakBackUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, Break?>> call({Map<String,dynamic>? body}) async {
    return await hrmCoreBaseService.backBreak(body: body);
  }
}

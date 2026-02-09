import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class NotificationFromServerUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  NotificationFromServerUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, NotificationDataModel?>> call() async {
    return await hrmCoreBaseService.getNotification();
  }
}

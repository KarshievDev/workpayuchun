import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SendPushNotificationRequestUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  SendPushNotificationRequestUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, bool>> call({required int receiverId, required String message}) async {
    return await hrmCoreBaseService.firebaseMessage(receiverId: receiverId, message: message);
  }
}

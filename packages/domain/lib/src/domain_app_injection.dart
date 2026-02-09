import 'package:core/core.dart';
import 'package:domain/domain.dart';

class DomainAppInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<LoginWithEmailPasswordUseCase>(
        LoginWithEmailPasswordUseCase(authenticationRepository: instance()));
    instance.registerSingleton<LogoutUseCase>(LogoutUseCase(authenticationRepository: instance()));
    instance.registerSingleton<LoadTravelMeetingUseCase>(LoadTravelMeetingUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitTravelExpenseUseCase>(SubmitTravelExpenseUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitTravelMeetingUseCase>(SubmitTravelMeetingUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitDailyReportUseCase>(SubmitDailyReportUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadTravelModeUseCase>(LoadTravelModeUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadTravelExpenseUseCase>(LoadTravelExpenseUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<LoadTravelCategoriesUseCase>(LoadTravelCategoriesUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SendPushNotificationRequestUseCase>(
        SendPushNotificationRequestUseCase(hrmCoreBaseService: instance()));
  }
}

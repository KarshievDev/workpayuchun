import 'package:core/core.dart';
import 'domain.dart';

class UseCaseInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<HomeDataLoadUseCase>(HomeDataLoadUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SettingsDataLoadUseCase>(SettingsDataLoadUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitAttendanceUseCase>(SubmitAttendanceUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<BreakBackUseCase>(BreakBackUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<BreakBackHistoryUseCase>(BreakBackHistoryUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<BreakBackQRVerifyUseCase>(BreakBackQRVerifyUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadDocumentRequest>(LoadDocumentRequest(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadDocumentRequestTypes>(LoadDocumentRequestTypes(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitDocumentRequest>(SubmitDocumentRequest(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadComplainUseCase>(LoadComplainUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitComplainUseCase>(SubmitComplainUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadComplainRepliesUseCase>(LoadComplainRepliesUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitComplainReplyUseCase>(SubmitComplainReplyUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitRemarksUseCase>(SubmitRemarksUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadTravelPlanUseCase>(LoadTravelPlanUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitTravelPlanUseCase>(SubmitTravelPlanUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadDailyReportUseCase>(LoadDailyReportUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LoadDeductionUseCase>(LoadDeductionUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<SubmitDeductionAppealUseCase>(SubmitDeductionAppealUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<LoadLeaveRequestTypeUseCase>(LoadLeaveRequestTypeUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<LoadLeaveRequestDataUseCase>(LoadLeaveRequestDataUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SubmitLeaveRequestUseCase>(SubmitLeaveRequestUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<LoadLeaveSummeryDataUseCase>(LoadLeaveSummeryDataUseCase(hrmCoreBaseService: instance()));
    instance
        .registerSingleton<LoadLeaveDetailsDataUseCase>(LoadLeaveDetailsDataUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<LeaveCancelRequestUseCase>(LeaveCancelRequestUseCase(hrmCoreBaseService: instance()));
  }
}

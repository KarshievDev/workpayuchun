import 'dart:async';
import 'dart:io';
import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/models/acts_regulation.dart';
import 'package:meta_club_api/src/models/anniversary.dart';
import 'package:meta_club_api/src/models/birthday.dart';
import 'package:meta_club_api/src/models/contact_search.dart';
import 'package:meta_club_api/src/models/donation.dart';
import 'package:meta_club_api/src/models/gallery.dart';
import 'package:user_repository/user_repository.dart';

class HRMCoreBaseServiceImpl implements HRMCoreBaseService {
  final ConnectivityStatusProvider connectivityStatusProvider;
  final MetaClubApiClient metaClubApiClient;

  HRMCoreBaseServiceImpl({required this.connectivityStatusProvider, required this.metaClubApiClient});

  @override
  Future<Either<Failure, LoginData?>> login(
      {required String email, required String password, String? deviceId, String? deviceInfo}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.login(email: email, password: password, deviceId: deviceId, deviceInfo: deviceInfo);
  }

  @override
  Future<Either<Failure, String>> appointmentCreate({AppointmentBody? appointmentBody}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }

    return metaClubApiClient.appointmentCreate(appointmentBody: appointmentBody);
  }

  @override
  Future<Either<Failure, bool>> approvalApprovedOrReject({required String approvalId, required int type}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.approvalApprovedOrReject(approvalId: approvalId, type: type);
  }

  @override
  Future<Either<Failure, Break?>> backBreak({Map<String, dynamic>? body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.backBreak(body: body);
  }

  @override
  Future<Either<Failure, bool>> cancelVisitApi({BodyVisitCancel? bodyVisitCancel}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.cancelVisitApi(bodyVisitCancel: bodyVisitCancel);
  }

  @override
  Future<Either<Failure, CheckData?>> checkInOut({required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.checkInOut(body: body);
  }

  @override
  Future<Either<Failure, bool>> checkQRValidations(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.checkQRValidations(data);
  }

  @override
  Future<Either<Failure, bool>> createConferenceApi({CreateConferenceBodyModel? conferenceBodyModel}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createConferenceApi(conferenceBodyModel: conferenceBodyModel);
  }

  @override
  Future<Either<Failure, bool>> createMeetingApi({MeetingBodyModel? meetingBodyModel}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createMeetingApi(meetingBodyModel: meetingBodyModel);
  }

  @override
  Future<Either<Failure, bool>> createRescheduleApi({BodyCreateSchedule? bodyCreateSchedule}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createRescheduleApi(bodyCreateSchedule: bodyCreateSchedule);
  }

  @override
  Future<Either<Failure, bool>> createSupport({BodyCreateSupport? bodyCreateSupport}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createSupport(bodyCreateSupport: bodyCreateSupport);
  }

  @override
  Future<Either<Failure, bool>> createSupportApi({required data}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createSupportApi(data: data);
  }

  @override
  Future<Either<Failure, bool>> createVisitApi({BodyCreateVisit? bodyCreateVisit}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.createVisitApi(bodyCreateVisit: bodyCreateVisit);
  }

  @override
  Future<Either<Failure, dynamic>> dailyLeaveApprovalAction(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.dailyLeaveApprovalAction(data);
  }

  @override
  Future<Either<Failure, DailyLeaveSummaryModel?>> dailyLeaveSummary(int? userId, String? date) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.dailyLeaveSummary(userId, date);
  }

  @override
  Future<Either<Failure, LeaveTypeListModel?>> dailyLeaveSummaryStaffView(
      {String? userId, String? month, String? leaveType, String? leaveStatus}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.dailyLeaveSummaryStaffView(
        userId: userId, month: month, leaveType: leaveType, leaveStatus: leaveStatus);
  }

  @override
  Future<Either<Failure, ExpenseCreateResponse>> expenseCreate({ExpenseCreateBody? expenseCreateBody}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.expenseCreate(expenseCreateBody: expenseCreateBody);
  }

  @override
  Future<Either<Failure, bool>> faceDataStore({String? faceData}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.faceDataStore(faceData: faceData);
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> forgetPassword({ForgotPasswordBody? forgotPasswordBody}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.forgetPassword(forgotPasswordBody: forgotPasswordBody);
  }

  @override
  Future<Either<Failure, ApprovalModel?>> getApprovalData() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getApprovalData();
  }

  @override
  Future<Either<Failure, ApprovalDetailsModel?>> getApprovalListDetails(
      {required String approvalId, required String approvalUserId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getApprovalListDetails(approvalId: approvalId, approvalUserId: approvalUserId);
  }

  @override
  Future<Either<Failure, AttendanceReport?>> getAttendanceReport(
      {required Map<String, dynamic> body, int? userId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getAttendanceReport(body: body, userId: userId);
  }

  @override
  Future<Either<Failure, ReportAttendanceSummary?>> getAttendanceReportSummary(
      {required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getAttendanceReportSummary(body: body);
  }

  @override
  Future<Either<Failure, SummaryAttendanceToList?>> getAttendanceSummaryToList(
      {required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getAttendanceSummaryToList(body: body);
  }

  @override
  Future<Either<Failure, BreakReportModel?>> getBreakHistory(String date) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getBreakHistory(date);
  }

  @override
  Future<Either<Failure, ReportBreakSummaryModel?>> getBreakSummary({required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getBreakSummary(body: body);
  }

  @override
  Future<Either<Failure, ReportBreakListModel?>> getBreakSummaryList({required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getBreakSummaryList(body: body);
  }

  @override
  Future<Either<Failure, ResponseExpenseList?>> getExpenseItem(
      String month, String? paymentType, String? status) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getExpenseItem(month, paymentType, status);
  }

  @override
  Future<Either<Failure, HistoryListModel?>> getHistoryList(String? month) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getHistoryList(month);
  }

  @override
  Future<Either<Failure, LeaveReportTypeWiseSummary?>> getLeaveSummaryTypeWise(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getLeaveSummaryTypeWise(data);
  }

  @override
  Future<Either<Failure, MeetingsListModel?>> getMeetingList(String? month) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getMeetingList(month);
  }

  @override
  Future<Either<Failure, MeetingsListModel?>> getMeetingsItem(String month) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getMeetingList(month);
  }

  @override
  Future<Either<Failure, NoticeListModel?>> getNoticeList() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getNoticeList();
  }

  @override
  Future<Either<Failure, PayrollModel?>> getPayrollData({required String year}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getPayrollData(year: year);
  }

  @override
  Future<Either<Failure, Profile?>> getProfile() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getProfile();
  }

  @override
  Future<Either<Failure, SupportListModel?>> getSupport(String type, String month) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getSupport(type, month);
  }

  @override
  Future<Either<Failure, ResponseUserList?>> getUserList(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getUserList(data);
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> getVerificationCode({String? email}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getVerificationCode(email: email);
  }

  @override
  Future<Either<Failure, LeaveDetailsModel?>> leaveDetailsApi(int? userId, int? requestId) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveDetailsApi(userId, requestId);
  }

  @override
  Future<Either<Failure, LeaveDetailsModel?>> leaveReportDetailsApi(int? userId, int leaveId) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveDetailsApi(userId, leaveId);
  }

  @override
  Future<Either<Failure, LeaveReportSummaryModel?>> leaveReportSummaryApi(String date) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveReportSummaryApi(date);
  }

  @override
  Future<Either<Failure, LeaveRequestModel?>> leaveRequestApi(int? userId, String? date) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveRequestApi(userId, date);
  }

  @override
  Future<Either<Failure, LeaveRequestTypeModel>> leaveRequestTypeApi(int? userId) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveRequestTypeApi(userId);
  }

  @override
  Future<Either<Failure, LeaveSummaryModel?>> leaveSummaryApi(int? userId) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.leaveSummaryApi(userId);
  }

  @override
  Future<Either<Failure, bool>> offlineCheckInOut({required Map<String, dynamic> body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.offlineCheckInOut(body: body);
  }

  @override
  Future<Either<Failure, dynamic>> postApplyLeave(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.postApplyLeave(data);
  }

  @override
  Future<Either<Failure, dynamic>> postBirthDayWish(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.postBirthDayWish(data);
  }

  @override
  Future<Either<Failure, dynamic>> postEventAppreciate(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.postEventAppreciate(data);
  }

  @override
  Future<Either<Failure, dynamic>> postEventGoing(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.postEventGoing(data);
  }

  @override
  Future<Either<Failure, dynamic>> postUserApproval(data) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.postUserApproval(data);
  }

  @override
  Future<Either<Failure, RegistrationData>> registration({bodyData}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.registration(bodyData: bodyData);
  }

  @override
  Future<Either<Failure, bool>> storeLocationToServer(
      {required List<Map<String, dynamic>> locations, String? date}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.storeLocationToServer(locations: locations, date: date);
  }

  @override
  Future<Either<Failure, bool>> submitLeaveRequestApi({BodyCreateLeaveModel? bodyCreateLeaveModel}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitLeaveRequestApi(bodyCreateLeaveModel: bodyCreateLeaveModel);
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> updatePassword({PasswordChangeBody? passwordChangeBody}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.updatePassword(passwordChangeBody: passwordChangeBody);
  }

  @override
  Future<Either<Failure, bool>> updateProfile({required String slag, required data}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.updateProfile(slag: slag, data: data);
  }

  @override
  Future<Either<Failure, bool>> updateProfileAvatar({required int avatarId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.updateProfileAvatar(avatarId: avatarId);
  }

  @override
  Future<Either<Failure, bool>> updateTaskStatusAndSlider({data}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.updateTaskStatusAndSlider(data: data);
  }

  @override
  Future<Either<Failure, bool>> updateVisitApi({BodyUpdateVisit? bodyUpdateVisit}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.updateVisitApi(bodyUpdateVisit: bodyUpdateVisit);
  }

  @override
  Future<Either<Failure, FileUpload?>> uploadFile({required File file}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.uploadFile(file: file);
  }

  @override
  Future<Either<Failure, bool>> visitCreateNoteApi({BodyVisitNote? bodyVisitNote}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.visitCreateNoteApi(bodyVisitNote: bodyVisitNote);
  }

  @override
  Future<Either<Failure, bool>> visitUploadImageApi({BodyImageUpload? bodyImageUpload}) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.visitUploadImageApi(bodyImageUpload: bodyImageUpload);
  }

  @override
  Future<Failure> logout() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const GeneralFailure.networkUnavailable();
    }
    return metaClubApiClient.logout();
  }

  @override
  Future<Either<Failure, ActsRegulationModel?>> actsRegulation() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.actsRegulation();
  }

  @override
  Future<bool> cancelLeaveRequest(int? requestId) async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return false;
    }
    return metaClubApiClient.cancelLeaveRequest(requestId);
  }

  @override
  Future<bool> clearAllNotificationApi() async {
    final isConnected = await connectivityStatusProvider.isConnected;

    if (!isConnected) {
      return false;
    }
    return metaClubApiClient.clearAllNotificationApi();
  }

  @override
  Future<bool> clearNoticeApi() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return false;
    }
    return metaClubApiClient.clearNoticeApi();
  }

  @override
  Future<Either<Failure, ContactsSearchList?>> contactsSearchList() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.contactsSearchList();
  }

  @override
  Future<Either<Failure, Events?>> events() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.events();
  }

  @override
  Future<Either<Failure, Galleries?>> galleries() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.galleries();
  }

  @override
  Future<Either<Failure, AnniversaryModel?>> getAnniversaries() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getAnniversaries();
  }

  @override
  Future<Either<Failure, BirthListModel?>> getBirthdays() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getBirthdays();
  }

  @override
  Future<Either<Failure, CompanyListModel?>> getCompanyList() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getCompanyList();
  }

  @override
  Future<Either<Failure, ConferenceModel?>> getConferenceList() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getConferenceList();
  }

  @override
  Future<Either<Failure, DashboardModel?>> getDashboardData() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getDashboardData();
  }

  @override
  Future<Either<Failure, DonationModel?>> getDonations() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getDonations();
  }

  @override
  Future<Either<Failure, ExpenseCategoryModel?>> getExpenseCategory() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getExpenseCategory();
  }

  @override
  Future<Either<Failure, NotificationDataModel?>> getNotification() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getNotification();
  }

  @override
  Future<Either<Failure, ResponseNoticeDetails?>> getNotificationDetails(int noticeId) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getNotificationDetails(noticeId);
  }

  @override
  Future<Either<Failure, Phonebook?>> getPhoneBooks(
      {String? keywords, int? designationId, int? departmentId, required int pageCount}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getPhoneBooks(
        pageCount: pageCount, keywords: keywords, designationId: designationId, departmentId: departmentId);
  }

  @override
  Future<Either<Failure, PhoneBookDetailsModel?>> getPhoneBooksUserDetails({String? userId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getPhoneBooksUserDetails(userId: userId);
  }

  @override
  Future<Either<Failure, ResponseAllContents?>> getPolicyData(String? slug) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getPolicyData(slug);
  }

  @override
  Future<Either<Failure, ResponseQualification?>> getQualification() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getQualification();
  }

  @override
  Future<Either<Failure, Settings?>> getSettings() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getSettings();
  }

  @override
  Future<Either<Failure, TaskDetailsModel?>> getTaskDetails(String taskId) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getTaskDetails(taskId);
  }

  @override
  Future<Either<Failure, TaskDashboardModel?>> getTaskInitialData({String? statuesId = '26'}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getTaskInitialData(statuesId: statuesId);
  }

  @override
  Future<Either<Failure, GetUserByIdResponse?>> getUserById(int? userId) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getUserById(userId);
  }

  @override
  Future<Either<Failure, VisitDetailsModel?>> getVisitDetailsApi(int? visitID) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getVisitDetailsApi(visitID);
  }

  @override
  Future<Either<Failure, VisitListModel?>> getVisitList() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getVisitList();
  }

  @override
  Future<Either<Failure, Notices?>> notices() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.notices();
  }

  @override
  Future<Either<Failure, VerifyQRData>> verifyQR({required String code}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.verifyQR(code: code);
  }

  @override
  Future<Either<Failure, DocumentTypes>> documentTypes() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.documentTypes();
  }

  @override
  Future<Either<Failure, DocumentItems>> documentItems({required int? statusCode}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.documentItems(statusCode: statusCode);
  }

  @override
  Future<Either<Failure, bool>> submitDocumentRequest({required DocumentBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitDocumentRequest(body: body);
  }

  @override
  Future<Either<Failure, ComplainData>> getComplains({String? date, bool complain = true}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getComplains(complain: complain);
  }

  @override
  Future<Either<Failure, bool>> submitComplain({required ComplainBody body, bool complain = true}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitComplain(body: body, complain: complain);
  }

  @override
  Future<Either<Failure, List<ComplainReply>>> complainReplies({required int complainId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.complainReplies(complainId: complainId);
  }

  @override
  Future<Either<Failure, bool>> submitComplainReply({required ComplainReplyBody body, required int complainId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.complainReplySubmit(body: body, complainId: complainId);
  }

  @override
  Future<Either<Failure, bool>> storeRemarks({required StoreRemarksBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.storeRemarks(body: body);
  }

  @override
  Future<Either<Failure, TravelPlanModel?>> getTravelPlans() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getTravelPlanList();
  }

  @override
  Future<Either<Failure, DailyReportListModel?>> getDailyReports() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getDailyReportList();
  }

  @override
  Future<Either<Failure, bool>> submitTravelPlanRequest({required TravelPlanBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitTravelPlan(body: body);
  }

  @override
  Future<Either<Failure, List<TravelCategory>>> travelCategories() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.travelCategories();
  }

  @override
  Future<Either<Failure, List<String>>> travelModes() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.travelModes();
  }

  @override
  Future<Either<Failure, TravelMeetingModel?>> getTravelMeeting({required int travelPlanId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getTravelMeetingList(travelPlanId: travelPlanId);
  }

  @override
  Future<Either<Failure, TravelExpense?>> getTravelPlanExpenses({required int travelPlanId}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getTravelPlanExpenses(travelPlanId: travelPlanId);
  }

  @override
  Future<Either<Failure, bool>> submitTravelPlanExpense({required TravelPlanExpenseBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitTravelPlanExpense(body: body);
  }

  @override
  Future<Either<Failure, bool>> submitTravelMeeting({required CreateTravelMeetingBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitTravelMeeting(body: body);
  }

  @override
  Future<Either<Failure, bool>> submitDailyReport({required SubmitDailyReportBody body}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitDailyReport(body: body);
  }

  @override
  Future<Either<Failure, DeductionData>> getDeductionData() async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.getDeductionData();
  }

  @override
  Future<Either<Failure, bool>> submitDeductionAppeal({required BodyAppeal body, required int deductionID}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.submitDeductionAppeal(body: body, deductionID: deductionID);
  }

  @override
  Future<Either<Failure, bool>> firebaseMessage({required int receiverId, required String message}) async {
    final isConnected = await connectivityStatusProvider.isConnected;
    if (!isConnected) {
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.firebaseMessage(receiverId: receiverId, message: message);
  }
}

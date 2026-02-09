import 'dart:async';
import 'dart:io';
import 'package:core/core.dart';
import 'package:dio_service/dio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/models/anniversary.dart';
import 'package:meta_club_api/src/models/birthday.dart';
import 'package:meta_club_api/src/models/contact_search.dart';
import 'package:meta_club_api/src/models/gallery.dart';
import 'package:meta_club_api/src/models/more.dart';
import 'package:user_repository/user_repository.dart';
import 'models/acts_regulation.dart';
import 'models/content.dart';
import 'models/donation.dart';
import 'package:dio/dio.dart';

class MetaClubApiClient {
  final HttpService httpService;

  MetaClubApiClient({required this.httpService});

  String getBaseUrl() {
    final baseUrl = globalState.get(companyUrl);
    return baseUrl;
  }

  Future<Either<Failure, LoginData?>> login(
      {required String email, required String password, String? deviceId, String? deviceInfo}) async {
    const String login = 'login';

    final body = {'email': email, 'password': password, "device_id": deviceId, "device_info": deviceInfo};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$login', body);
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return right(LoginData.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Failure> logout() async {
    const String logout = 'logout';
    final response = await httpService.getRequestWithToken('${getBaseUrl()}$logout');
    return response.fold((l) {
      return l;
    }, (r) {
      return const GeneralFailure.none();
    });
  }

  Future<Either<Failure, RegistrationData>> registration({bodyData}) async {
    const String register = 'register';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$register', bodyData);

      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(RegistrationData.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, CompanyListModel?>> getCompanyList() async {
    const String api = '$rootUrl/api/v71/company-list';
    try {
      final response = await httpService.getRequestWithToken(api);
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(CompanyListModel.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Settings?>> getSettings() async {
    const String api = 'app/base-settings';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(Settings.fromJson(r.data));
      });
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, SupportListModel?>> getSupport(String type, String month) async {
    const String api = 'support-ticket/list';
    final data = {"type": type, "month": month};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(SupportListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, CheckData?>> checkInOut({required Map<String, dynamic> body}) async {
    const String api = 'user/attendance';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => Right(CheckData.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> offlineCheckInOut({required Map<String, dynamic> body}) async {
    //const String api = 'user/attendance/offline';

    try {
      // final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      // return response.fold(
      //   (l) => Left(l),
      //   (r) => const Right(true),
      // );
      return Left(GeneralFailure.ineligible());
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, AttendanceReport?>> getAttendanceReport(
      {required Map<String, dynamic> body, int? userId}) async {
    final String api = 'report/attendance/particular-month/$userId';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => Right(AttendanceReport.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Break?>> backBreak({Map<String, dynamic>? body}) async {
    const String api = 'user/attendance/break-back';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold(
        (l) => Left(l),
        (r) => Right(Break.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DashboardModel?>> getDashboardData() async {
    const String api = 'dashboard/statistics';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(DashboardModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveDetailsModel?>> leaveReportDetailsApi(int? userId, int leaveId) async {
    const String api = 'user/leave/details';

    try {
      final data = {"user_id": userId};
      final response = await httpService.postRequest('${getBaseUrl()}$api/$leaveId', data);

      return response.fold((l) => Left(l), (r) => Right(LeaveDetailsModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveReportTypeWiseSummary?>> getLeaveSummaryTypeWise(data) async {
    const String api = 'report/leave/date-wise-leave';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveReportTypeWiseSummary.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveSummaryModel?>> leaveSummaryApi(int? userId) async {
    const String api = 'user/leave/summary';

    try {
      final formData = {
        "user_id": userId,
      };
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold((l) => Left(l), (r) => Right(LeaveSummaryModel.fromJson(r.data)));
    } on Exception catch (e) {
      return left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveReportSummaryModel?>> leaveReportSummaryApi(String date) async {
    const String api = 'report/leave/date-summary';
    final data = {'date': date};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveReportSummaryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveDetailsModel?>> leaveDetailsApi(int? userId, int? requestId) async {
    final String api = "user/leave/details/$requestId";

    try {
      final data = {"user_id": userId};
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveDetailsModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<bool> cancelLeaveRequest(int? requestId) async {
    String api = 'user/leave/request/cancel/$requestId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => false,
        (r) => true,
      );
    } catch (_) {
      return false;
    }
  }

  Future<Either<Failure, bool>> submitLeaveRequestApi({BodyCreateLeaveModel? bodyCreateLeaveModel}) async {
    const String api = 'user/leave/request';
    if (kDebugMode) {
      print(bodyCreateLeaveModel?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyCreateLeaveModel!.toJson());
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> cancelVisitApi({BodyVisitCancel? bodyVisitCancel}) async {
    const String api = 'visit/change-status';
    if (kDebugMode) {
      print(bodyVisitCancel?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyVisitCancel!.toJson());
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createRescheduleApi({BodyCreateSchedule? bodyCreateSchedule}) async {
    const String api = 'visit/create-schedule';
    if (kDebugMode) {
      print(bodyCreateSchedule?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyCreateSchedule!.toJson());
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> visitUploadImageApi({BodyImageUpload? bodyImageUpload}) async {
    const String api = 'visit/image-upload';
    if (kDebugMode) {
      print(bodyImageUpload?.toJson());
    }
    try {
      final formData = FormData.fromMap(bodyImageUpload!.toJson());
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> updateVisitApi({BodyUpdateVisit? bodyUpdateVisit}) async {
    const String api = 'visit/update';

    if (kDebugMode) {
      print(bodyUpdateVisit?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyUpdateVisit!.toJson());
      await httpService.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> visitCreateNoteApi({BodyVisitNote? bodyVisitNote}) async {
    const String api = 'visit/create-note';

    if (kDebugMode) {
      print(bodyVisitNote?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyVisitNote!.toJson());
      await httpService.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createConferenceApi({CreateConferenceBodyModel? conferenceBodyModel}) async {
    const String api = "conference/create";

    try {
      FormData formData = FormData.fromMap(conferenceBodyModel!.toJson());
      await httpService.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createMeetingApi({MeetingBodyModel? meetingBodyModel}) async {
    const String api = "meeting/create";

    try {
      FormData formData = FormData.fromMap(meetingBodyModel!.toJson());
      await httpService.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createVisitApi({BodyCreateVisit? bodyCreateVisit}) async {
    const String api = 'visit/create';

    if (kDebugMode) {
      print(bodyCreateVisit?.toJson());
    }
    try {
      FormData formData = FormData.fromMap(bodyCreateVisit!.toJson());
      await httpService.postRequest('${getBaseUrl()}$api', formData);
      return const Right(true);
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveRequestTypeModel>> leaveRequestTypeApi(int? userId) async {
    const String api = 'user/leave/available';

    try {
      FormData formData = FormData.fromMap({"user_id": userId});
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold((l) => Left(l), (r) => Right(LeaveRequestTypeModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DailyLeaveSummaryModel?>> dailyLeaveSummary(int? userId, String? date) async {
    const String api = 'daily-leave/leave-list';
    try {
      FormData formData = FormData.fromMap({"user_id": userId, "date": date});
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(DailyLeaveSummaryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveTypeListModel?>> dailyLeaveSummaryStaffView({
    String? userId,
    String? month,
    String? leaveType,
    String? leaveStatus,
  }) async {
    const String api = 'daily-leave/staff-list-view';
    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "month": month,
        "leave_type": leaveType,
        "leave_status": leaveStatus,
      });
      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(LeaveTypeListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> postApplyLeave(data) async {
    const String api = 'daily-leave/store';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> dailyLeaveApprovalAction(data) async {
    const String api = 'daily-leave/approve-reject';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Profile?>> getProfile() async {
    const String api = 'user/profile-info';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', {});
      return response.fold(
        (l) => Left(l),
        (r) => Right(Profile.fromJson(r.data['data'])),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createSupportApi({required data}) async {
    String api = 'user/profile/update/';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> updateProfile({required String slag, required data}) async {
    String api = 'user/profile/update/$slag';

    try {
      debugPrint('body: $data');

      FormData formData = FormData.fromMap(data);

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> createSupport({BodyCreateSupport? bodyCreateSupport}) async {
    String api = 'support-ticket/add';

    try {
      debugPrint('body: $bodyCreateSupport');

      FormData formData = FormData.fromMap({
        "subject": bodyCreateSupport?.subject,
        "description": bodyCreateSupport?.description,
        "image_url": bodyCreateSupport?.previewId,
        "priority_id": bodyCreateSupport?.priorityId,
      });

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> updateProfileAvatar({required int avatarId}) async {
    String api = 'user/profile-update';

    try {
      debugPrint('body: ${{"avatar_id": avatarId}}');

      FormData formData = FormData.fromMap({"avatar_id": avatarId});

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception:e));
    }
  }

  Future<Either<Failure, FileUpload?>> uploadFile({required File file}) async {
    const String api = 'file-upload';

    try {
      FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => Right(FileUpload.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ContactsSearchList?>> contactsSearchList() async {
    const String api = 'user/search?name=';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ContactsSearchList.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Live Location store API -----------------
  Future<Either<Failure, bool>> storeLocationToServer({
    required List<Map<String, dynamic>> locations,
    String? date,
  }) async {
    try {
      final data = {'locations': locations, 'date': date};
      var response = await httpService.postRequest(
        "${getBaseUrl()}user/attendance/live-location-store",
        data,
      );
      return response.fold(
        (l) => Left(l),
        (_) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Notices?>> notices() async {
    const String api = 'notices/get-list';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(Notices.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  ///========================== Event =====================
  Future<Either<Failure, Events?>> events() async {
    const String api = 'events/get-list';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(Events.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  ///========================== More =====================
  Future<Mores?> mores() async {
    const String api = 'content/list';
    try {
      final response = await httpService.getRequest('${getBaseUrl()}$api');

      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Mores.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Content?> getContent({required String slug}) async {
    try {
      final response = await httpService.getRequest(slug);
      if (response?.statusCode != 200) {
        throw NetworkRequestFailure(response?.statusMessage ?? 'server error');
      }
      return Content.fromJson(response?.data);
    } catch (_) {
      return null;
    }
  }

  Future<Either<Failure, dynamic>> postEventGoing(data) async {
    const String api = 'events/going';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> postEventAppreciate(data) async {
    const String api = 'events/appreciate';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> postUserApproval(data) async {
    const String api = 'user/approval';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, Galleries?>> galleries() async {
    const String api = 'events/gallery-photo';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(Galleries.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, BirthListModel?>> getBirthdays() async {
    const String api = 'birthday/get-list?month=07';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(BirthListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, dynamic>> postBirthDayWish(data) async {
    const String api = 'birthday/message/store';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseUserList?>> getUserList(data) async {
    const String api = 'list-users';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseUserList.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, AnniversaryModel?>> getAnniversaries() async {
    const String api = 'anniversary/get-list';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(AnniversaryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, GetUserByIdResponse?>> getUserById(int? userId) async {
    const String api = 'user/';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api$userId');
      return response.fold(
        (l) => Left(l),
        (r) => Right(GetUserByIdResponse.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseQualification?>> getQualification() async {
    const String api = 'qualifications';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseQualification.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DonationModel?>> getDonations() async {
    const String api = 'donation/get-list';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(DonationModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  ///================== Acts & Regulation ===================
  Future<Either<Failure, ActsRegulationModel?>> actsRegulation() async {
    const String api = 'content/act-regulations';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ActsRegulationModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, NotificationDataModel?>> getNotification() async {
    const String api = 'user/notification';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(NotificationDataModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseNoticeDetails?>> getNotificationDetails(int noticeId) async {
    const String api = 'notice/show';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api/$noticeId');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseNoticeDetails.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, NoticeListModel?>> getNoticeList() async {
    const String api = 'notice/list';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', '');

      return response.fold(
        (l) => Left(l),
        (r) => Right(NoticeListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseAllContents?>> getPolicyData(String? slug) async {
    const String api = 'app/all-contents/';

    try {
      final response = await httpService.getRequestWithToken(
        '${getBaseUrl()}$api$slug',
      );
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseAllContents.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

///// All Notification ///////////
  Future<bool> clearAllNotificationApi() async {
    const String clear = 'user/notification/clear';
    final response = await httpService.getRequestWithToken('${getBaseUrl()}$clear');
    return response.fold((l) => false, (r) => true);
  }

  ///// All Notification ///////////
  Future<bool> clearNoticeApi() async {
    const String clear = 'notice/clear';
    final response = await httpService.getRequestWithToken('${getBaseUrl()}$clear');
    return response.fold((l) => false, (r) => true);
  }

  /// ================== Phonebook ====================
  Future<Either<Failure, Phonebook?>> getPhoneBooks(
      {String? keywords, int? designationId, int? departmentId, required int pageCount}) async {
    String api =
        'app/get-all-employees?search=${keywords ?? ''}&designation_id=${designationId ?? ''}&department_id=${departmentId ?? ''}&page=$pageCount&per_page=20';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(Phonebook.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ================== Phonebook Details====================
  Future<Either<Failure, PhoneBookDetailsModel?>> getPhoneBooksUserDetails({String? userId}) async {
    String api = 'user/details/$userId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(PhoneBookDetailsModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Task Dashboard Data ========================
  Future<Either<Failure, TaskDashboardModel?>> getTaskInitialData({String? statuesId = '26'}) async {
    String api = 'tasks?status=$statuesId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(TaskDashboardModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Tasks Details ========================
  Future<Either<Failure, TaskDetailsModel?>> getTaskDetails(String taskId) async {
    String api = 'tasks/$taskId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(TaskDetailsModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> updateTaskStatusAndSlider({data}) async {
    const String api = 'tasks/update';

    try {
      FormData formData = FormData.fromMap(data);

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);
      return response.fold(
        (l) => Left(l),
        (r) => const Right(true),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, MeetingsListModel?>> getMeetingsItem(String month) async {
    const String api = 'appoinment/get-list';
    final data = {"month": month};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(MeetingsListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ResponseExpenseList?>> getExpenseItem(
      String month, String? paymentType, String? status) async {
    const String api = 'accounts/expense/list';
    final data = {"month": month, "payment": paymentType, "status": status};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(ResponseExpenseList.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, BreakReportModel?>> getBreakHistory(
    String date,
  ) async {
    const String api = 'user/attendance/break-history';
    final data = {"date": date};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(BreakReportModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ExpenseCategoryModel?>> getExpenseCategory() async {
    String api = 'accounts/expense/category-list';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ExpenseCategoryModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, String>> appointmentCreate({AppointmentBody? appointmentBody}) async {
    String api = 'appoinment/create';

    try {
      FormData formData = FormData.fromMap({
        "title": appointmentBody?.title,
        "description": appointmentBody?.description,
        "appoinment_with": appointmentBody?.appointmentWith,
        "date": appointmentBody?.date,
        "location": appointmentBody?.location,
        "appoinment_start_at": appointmentBody?.appointmentStartDate,
        "appoinment_end_at": appointmentBody?.appointmentEndDate,
        "file_id": appointmentBody?.previewId,
      });

      final response = await httpService.postRequest('${getBaseUrl()}$api', formData);

      return response.fold(
        (l) => Left(l),
        (r) => Right(r.data['message']),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, LeaveRequestModel?>> leaveRequestApi(int? userId, String? date) async {
    const String api = 'user/leave/list/view';

    try {
      final data = {"user_id": userId, "month": date};
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(LeaveRequestModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> forgetPassword({ForgotPasswordBody? forgotPasswordBody}) async {
    String api = 'change-password';

    try {
      final data = {
        "email": forgotPasswordBody?.email,
        "code": forgotPasswordBody?.code,
        "password": forgotPasswordBody?.password,
        "password_confirmation": forgotPasswordBody?.passwordConfirmation
      };

      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> updatePassword({PasswordChangeBody? passwordChangeBody}) async {
    String api = 'user/password-update';

    try {
      final data = {
        "user_id": passwordChangeBody?.userId,
        "current_password": passwordChangeBody?.currentPassword,
        "password": passwordChangeBody?.password,
        "password_confirmation": passwordChangeBody?.passwordConfirmation,
      };

      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, VerificationCodeModel>> getVerificationCode({String? email}) async {
    String api = 'reset-password';

    try {
      final data = {"email": email};

      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold(
        (l) => Left(l),
        (r) => Right(VerificationCodeModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ExpenseCreateResponse>> expenseCreate({ExpenseCreateBody? expenseCreateBody}) async {
    String api = 'expense/add';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', expenseCreateBody?.toJson());

      return response.fold(
        (l) => Left(l),
        (r) => Right(ExpenseCreateResponse.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, PayrollModel?>> getPayrollData({required String year}) async {
    const String api = 'report/payslip/list';

    final data = {"year": year.toString()};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(PayrollModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ApprovalModel?>> getApprovalData() async {
    const String api = 'user/leave/approval/list/view';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', '');
      return response.fold(
        (l) => Left(l),
        (r) => Right(ApprovalModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Visit Details API
  Future<Either<Failure, VisitDetailsModel?>> getVisitDetailsApi(int? visitID) async {
    String api = 'visit/show/$visitID';

    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(VisitDetailsModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// History List API
  Future<Either<Failure, HistoryListModel?>> getHistoryList(String? month) async {
    const String api = 'visit/history';

    final data = {"month": month};

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold(
        (l) => Left(l),
        (r) => Right(HistoryListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Visit List ========================
  Future<Either<Failure, VisitListModel?>> getVisitList() async {
    const String api = 'visit/list';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(VisitListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Meeting List ========================
  Future<Either<Failure, MeetingsListModel?>> getMeetingList(String? month) async {
    const String api = 'meeting';
    final data = {"month": month};
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(MeetingsListModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ================== Approval Details====================
  Future<Either<Failure, ApprovalDetailsModel?>> getApprovalListDetails(
      {required String approvalId, required String approvalUserId}) async {
    String api = 'user/leave/details/$approvalId';
    final data = {"user_id": approvalUserId};
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold((l) => Left(l), (r) => Right(ApprovalDetailsModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ================== Action Approval Approved or Reject ====================
  Future<Either<Failure, bool>> approvalApprovedOrReject({required String approvalId, required int type}) async {
    String api = 'user/leave/approval/status-change/$approvalId/$type';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Summary of attendance  ------------------
  Future<Either<Failure, ReportAttendanceSummary?>> getAttendanceReportSummary(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/date-summary';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportAttendanceSummary.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Single Attendance Summary to List  ------------------
  Future<Either<Failure, SummaryAttendanceToList?>> getAttendanceSummaryToList(
      {required Map<String, dynamic> body}) async {
    String api = 'report/attendance/summary-to-list';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(SummaryAttendanceToList.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Report Break Summary  ------------------
  Future<Either<Failure, ReportBreakSummaryModel?>> getBreakSummary({required Map<String, dynamic> body}) async {
    String api = 'report/break/date-summary';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportBreakSummaryModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Report Break List Summary  ------------------
  Future<Either<Failure, ReportBreakListModel?>> getBreakSummaryList({required Map<String, dynamic> body}) async {
    String api = 'report/break/user-break-history';

    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => Right(ReportBreakListModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Conference List  ------------------
  Future<Either<Failure, ConferenceModel?>> getConferenceList() async {
    const String api = 'conference/my-meeting';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(ConferenceModel.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Check QR Code validations  ------------------
  Future<Either<Failure, bool>> checkQRValidations(data) async {
    const String api = 'user/attendance/qr-status';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Face data store
  Future<Either<Failure, bool>> faceDataStore({String? faceData}) async {
    String api = 'check-face-data';

    try {
      final data = {"face_data": faceData};

      final response = await httpService.postRequest('${getBaseUrl()}$api', data);

      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// Qr verification
  Future<Either<Failure, VerifyQRData>> verifyQR({String? code}) async {
    String api = 'breaks/qr-code-verify/$code';
    try {
      final data = {'code': code};
      final response = await httpService.postRequest('${getBaseUrl()}$api', data);
      return response.fold((l) => Left(l), (r) => Right(VerifyQRData.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DocumentTypes>> documentTypes() async {
    String api = 'user-document-types';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(DocumentTypes.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, DocumentItems>> documentItems({required int? statusCode}) async {
    String api = 'user-document-requests?response_status=$statusCode';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(DocumentItems.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> submitDocumentRequest({required DocumentBody body}) async {
    String api = 'user-document-requests';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, ComplainData>> getComplains({String? date, bool complain = true}) async {
    String api = complain ? 'complains?date=$date' : 'verbal-warnings?date=$date';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(ComplainData.fromJson(r.data['data'])));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> submitComplain({required ComplainBody body, bool complain = true}) async {
    String api = complain ? 'complains' : 'verbal-warnings';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, List<ComplainReply>>> complainReplies({required int complainId}) async {
    String api = 'complains/feedbacks/$complainId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
          (l) => Left(l),
          (r) =>
              Right(List<ComplainReply>.from((r.data['data']['data'] as List).map((e) => ComplainReply.fromJson(e)))));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> complainReplySubmit({required int complainId, required ComplainReplyBody body}) async {
    String api = 'complains/feedback/$complainId';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, bool>> storeRemarks({required StoreRemarksBody body}) async {
    String api = 'store-remarks';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Travel plan List ========================
  Future<Either<Failure, TravelPlanModel?>> getTravelPlanList() async {
    const String api = 'travel-plans';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(TravelPlanModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Submit Travel Plan ========================
  Future<Either<Failure, bool>> submitTravelPlan({required TravelPlanBody body}) async {
    String api = 'travel-plans';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Travel Meeting List ========================
  Future<Either<Failure, TravelMeetingModel?>> getTravelMeetingList({required int travelPlanId}) async {
    String api = 'travel-meetings?travel_plan_id=$travelPlanId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(TravelMeetingModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, List<TravelCategory>>> travelCategories() async {
    String api = 'travel-expenses/categories';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l),
          (r) => Right(List<TravelCategory>.from((r.data['data'] as List).map((e) => TravelCategory.fromJson(e)))));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, List<String>>> travelModes() async {
    String api = 'travel-expenses/modes';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(List<String>.from(r.data['data'] as List)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  Future<Either<Failure, TravelExpense?>> getTravelPlanExpenses({required int travelPlanId}) async {
    String api = 'travel-expenses?travel_plan_id=$travelPlanId';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(TravelExpense.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Submit Travel Plan Expense  ========================
  Future<Either<Failure, bool>> submitTravelPlanExpense({required TravelPlanExpenseBody body}) async {
    String api = 'travel-expenses';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Submit Travel Plan Expense  ========================
  Future<Either<Failure, bool>> submitTravelMeeting({required CreateTravelMeetingBody body}) async {
    String api = 'travel-meetings';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Submit Daily Report Expense  ========================
  Future<Either<Failure, bool>> submitDailyReport({required SubmitDailyReportBody body}) async {
    String api = 'travel-workflows';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body.toJson());
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Daily Report List ========================
  Future<Either<Failure, DailyReportListModel?>> getDailyReportList() async {
    const String api = 'travel-workflows';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold(
        (l) => Left(l),
        (r) => Right(DailyReportListModel.fromJson(r.data)),
      );
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  ///getDeductionData
  Future<Either<Failure, DeductionData>> getDeductionData() async {
    const String api = 'deductions';
    try {
      final response = await httpService.getRequestWithToken('${getBaseUrl()}$api');
      return response.fold((l) => Left(l), (r) => Right(DeductionData.fromJson(r.data)));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  /// ===================== Submit Deduction Appeal  ========================
  Future<Either<Failure, bool>> submitDeductionAppeal({required BodyAppeal body, required int deductionID}) async {
    String api = 'deductions/appeal/$deductionID';
    try {
      final response = await httpService.postRequest('${getBaseUrl()}$api', body);
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  ///========================firebaseMessage==================================
  Future<Either<Failure, bool>> firebaseMessage({required int receiverId, required String message}) async {
    String api = 'user/phonebook/firebase-messaging';
    try {
      final response =
          await httpService.postRequest('${getBaseUrl()}$api', {"receiver_id": receiverId, "message": message});
      return response.fold((l) => Left(l), (r) => const Right(true));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }
}

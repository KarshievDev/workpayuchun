import 'package:hrm_framework/hrm_framework.dart';

class GetAppVersionUseCase {
  final AppVersionService appVersionService;

  GetAppVersionUseCase({required this.appVersionService});

  Future<String> call() {
    return appVersionService.getAppVersion();
  }
}

import 'package:hrm_framework/hrm_framework.dart';

class GetAppNameUseCase {
  final AppVersionService appVersionService;

  GetAppNameUseCase({required this.appVersionService});

  Future<String> call() async {
    return appVersionService.getAppName();
  }
}

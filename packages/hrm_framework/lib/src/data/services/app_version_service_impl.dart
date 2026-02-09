import 'package:hrm_framework/src/domain/services/app_version_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionServiceImpl implements AppVersionService {
  @override
  Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return '${info.version}.${info.buildNumber}';
  }

  @override
  Future<String> getAppName() async {
    final info = await PackageInfo.fromPlatform();
    return info.appName;
  }
}

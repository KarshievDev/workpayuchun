import 'package:hrm_framework/hrm_framework.dart';

class GetDeviceIdUseCase {
  final DeviceInfoService deviceInfoService;

  GetDeviceIdUseCase({required this.deviceInfoService});

  Future<String?> call() {
    return deviceInfoService.getDeviceId();
  }

}

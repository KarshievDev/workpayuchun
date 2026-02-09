import 'package:hrm_framework/hrm_framework.dart';

class GetDeviceNameUseCase {
  final DeviceInfoService deviceInfoService;

  GetDeviceNameUseCase({required this.deviceInfoService});

  Future<String?> call() {
    return deviceInfoService.getDeviceName();
  }
}

 import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hrm_framework/src/domain/services/device_info_service.dart';

class DeviceInfoServiceImpl implements DeviceInfoService {
  @override
  Future<String?> getDeviceId() async {
    ///Platform information
    final deviceInfo = DeviceInfoPlugin();
    final info = Platform.isIOS ? await deviceInfo.iosInfo : await deviceInfo.androidInfo;
    return Platform.isIOS ? (info as IosDeviceInfo).identifierForVendor : (info as AndroidDeviceInfo).id;
  }

  @override
  Future<String?> getDeviceName() async {
    ///Platform information
    final deviceInfo = DeviceInfoPlugin();
    final info = Platform.isIOS ? await deviceInfo.iosInfo : await deviceInfo.androidInfo;
    return Platform.isIOS ? (info as IosDeviceInfo).name : (info as AndroidDeviceInfo).model;
  }
}

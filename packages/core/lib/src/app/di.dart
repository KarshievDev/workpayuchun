import 'package:core/core.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initHRMAppModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  instance.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>());
  instance.registerLazySingleton<EventBus>(() => EventBus());
  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);
  instance.registerLazySingleton<StorageHelper>(() => StorageHelperImpl(pref: instance()));
  instance.registerSingleton<BrandingColorProvider>(BrandingColorProvider());
  instance.registerSingleton<Branding>(Branding());
  instance.registerFactory<DeviceInfoService>(() => DeviceInfoServiceImpl());
  instance.registerFactory<AppVersionService>(() => AppVersionServiceImpl());
  instance.registerFactory<GetAppNameUseCase>(
      () => GetAppNameUseCase(appVersionService: instance()));
  instance.registerFactory<GetAppVersionUseCase>(
      () => GetAppVersionUseCase(appVersionService: instance()));
  instance.registerFactory<GetDeviceIdUseCase>(
      () => GetDeviceIdUseCase(deviceInfoService: instance()));
  instance.registerFactory<GetDeviceNameUseCase>(
      () => GetDeviceNameUseCase(deviceInfoService: instance()));
}

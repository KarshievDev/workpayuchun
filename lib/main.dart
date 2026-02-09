import 'dart:io';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notification/notification.dart';
import 'package:strawberryhrm/injection/hrm_app_injection.dart';
import 'package:strawberryhrm/presentation/app/hrm_app.dart';
import 'package:strawberryhrm/presentation/app/app_bloc_state_observer.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///initializeEasyLocalization
  await EasyLocalization.ensureInitialized();

  ///initializeFirebaseAtStatingPoint
  await Firebase.initializeApp();

  ///initializeDependencyInjection
  await initHRMAppModule();

  ///OtherDependencyInjection
  await HRMAppInjection().initInjection();
  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(directory.path),
  );
  Bloc.observer = AppBlocStateObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final appView = instance<AppFactory>();
  await instance<NotificationAppStartedHandlerService>().onAppStarted();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BN'),
        Locale('ar', 'AR'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: appView(),
    ),
  );
}

Future<void> updateHRMAppWidget({required bool isCheckedIn}) async {
  await HomeWidget.saveWidgetData<bool>('isCheckedIn', isCheckedIn);
  await HomeWidget.updateWidget(
    name: 'HomeScreenCheckInOutWidgetProvider',
    iOSName: 'HomeScreenCheckInOutWidgetProvider',
    qualifiedAndroidName:
        'com.example.strawberryhrm.HomeScreenCheckInOutWidgetProvider',
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart' as presentation;
import 'package:strawberryhrm/presentation/splash/view/splash.dart';

class SplashInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<presentation.SplashScreenFactory>(_SplashScreenFactoryImpl());
  }
}

class _SplashScreenFactoryImpl extends presentation.SplashScreenFactory {
  @override
  Widget call() => const SplashScreen();
}

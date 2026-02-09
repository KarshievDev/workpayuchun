import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart' as presentation;
import 'package:strawberryhrm/presentation/login/login.dart';

class LoginInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<presentation.LoginPageFactory>(_LoginPageFactoryImpl());
  }
}

class _LoginPageFactoryImpl extends presentation.LoginPageFactory {
  @override
  Widget call() => const LoginPage();
}

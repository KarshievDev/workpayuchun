import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart' as presentation;
import 'package:strawberryhrm/presentation/bottom_navigation/view/bottom_navigation_page.dart';

class BottomNavInjection {
  Future<void> initInjection() async {
    instance.registerFactory<presentation.BottomNavigationFactory>(() => _BottomNavigationFactoryImpl());
  }
}

class _BottomNavigationFactoryImpl extends presentation.BottomNavigationFactory {
  @override
  Widget call() => BottomNavigationPage(homeBlocFactor: instance());
}

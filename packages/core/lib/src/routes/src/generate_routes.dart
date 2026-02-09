import 'package:core/src/routes/src/route.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

typedef OnGeneratedRoutesFactory = OnGeneratedRoutes Function();

class OnGeneratedRoutes {
  final BottomNavigationFactory bottomNavigationFactory;
  final SplashScreenFactory splashScreenFactory;
  final LoginPageFactory loginPageFactory;
  final OnboardingPageFactory onboardingPageFactory;
  final VoiceScreenFactory voiceScreenFactory;
  final NotFoundScreenFactory notFoundScreenFactory;

  OnGeneratedRoutes({
    required this.bottomNavigationFactory,
    required this.splashScreenFactory,
    required this.loginPageFactory,
    required this.onboardingPageFactory,
    required this.voiceScreenFactory,
    required this.notFoundScreenFactory,
  });

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => splashScreenFactory.call(),
        );
      case Routes.bottomNavigation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => bottomNavigationFactory.call(),
        );
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => loginPageFactory.call(),
        );
      case Routes.onboarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => onboardingPageFactory.call(),
        );
      case Routes.voiceIO:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => voiceScreenFactory.call(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => notFoundScreenFactory.call(),
        );
    }
  }
}

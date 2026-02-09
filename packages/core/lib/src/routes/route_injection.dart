import 'package:core/core.dart';
import 'package:presentation/presentation.dart' as presentation;

class RouteInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<OnGeneratedRoutesFactory>(
      () => OnGeneratedRoutes(
        bottomNavigationFactory: instance<presentation.BottomNavigationFactory>(),
        splashScreenFactory: instance<presentation.SplashScreenFactory>(),
        loginPageFactory: instance<presentation.LoginPageFactory>(),
        onboardingPageFactory: instance<presentation.OnboardingPageFactory>(),
        voiceScreenFactory: instance<presentation.VoiceScreenFactory>(),
        notFoundScreenFactory: instance<presentation.NotFoundScreenFactory>(),
      ),
    );
  }
}

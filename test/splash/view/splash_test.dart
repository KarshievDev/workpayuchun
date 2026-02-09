import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawberryhrm/presentation/splash/view/splash.dart';
import '../../domain/usecases.dart';
import '../../main_test.dart';

void main() async {
  late AuthenticationBloc authenticationBloc;
  late AuthenticationRepository authenticationRepository;
  late MockHRMCoreBaseService mockHRMCoreBaseService;
  late MockOnboardingBloc onboardingBloc;

  setUpAll(() async {
    await initHydratedStorage();
    mockHRMCoreBaseService = MockHRMCoreBaseService();
    authenticationRepository = AuthenticationRepository(hrmCoreBaseService: mockHRMCoreBaseService);
    authenticationBloc = AuthenticationBloc(authenticationRepository: authenticationRepository);
    onboardingBloc = MockOnboardingBloc();
    when(() => onboardingBloc.state).thenReturn(const OnboardingState());
    when(() => onboardingBloc.stream).thenAnswer((_) => const Stream<OnboardingState>.empty());
  });

  group('Splash screen', () {
    group('Render splash screen', () {
      testWidgets('Find SplashScreen widget', (tester) async {
        await tester.pumpWidget(MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
          BlocProvider<OnboardingBloc>.value(value: onboardingBloc),
        ], child: const MaterialApp(home: SplashScreen())));
        expect(find.byType(SplashScreen), findsOneWidget);
      });

      testWidgets('Find splash screen logo', (tester) async {
        await tester.pumpWidget(MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
          BlocProvider<OnboardingBloc>.value(value: onboardingBloc),
        ], child: const MaterialApp(home: SplashScreen())));
        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('Check splash screen logo is same as appLogo', (tester) async {
        await tester.pumpWidget(MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
          BlocProvider<OnboardingBloc>.value(value: onboardingBloc),
        ], child: const MaterialApp(home: SplashScreen())));
        expect(find.byKey(const ValueKey('SPLASH_LOGO')), findsOneWidget);
      });
    });
  });
}
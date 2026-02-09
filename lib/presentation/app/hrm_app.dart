import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/app_permission_page/app_permission_page.dart';
import 'package:strawberryhrm/presentation/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/bottom_navigation/view/bottom_navigation_page.dart';
import 'package:strawberryhrm/presentation/internet_connectivity/bloc/internet_bloc.dart';
import 'package:strawberryhrm/presentation/language/bloc/language_bloc.dart';
import 'package:strawberryhrm/presentation/login/view/login_page.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:strawberryhrm/presentation/onboarding/view/onboarding_page.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';

typedef AppFactory = HRMApp Function();

class HRMApp extends StatelessWidget {
  const HRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingBloc = instance<OnboardingBlocFactory>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => onBoardingBloc()),
        BlocProvider(create: (_) => AuthenticationBloc(authenticationRepository: instance())),
        BlocProvider(create: (_) => InternetBloc()..checkConnectionStatus()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => OfflineCubit(offlineAttendanceRepo: instance(), eventBus: instance())),
      ],
      child: const HRMAppView(),
    );
  }
}

class HRMAppView extends StatefulWidget {
  const HRMAppView({super.key});

  @override
  State<HRMAppView> createState() => HRMAppViewState();
}

class HRMAppViewState extends State<HRMAppView> {
  NavigatorState get _navigator => instance<GlobalKey<NavigatorState>>().currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (_, state) {
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            final generatedRoute = instance<OnGeneratedRoutesFactory>();

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: instance<GlobalKey<NavigatorState>>(),
              navigatorObservers: [GlobalVoiceButtonManager()],
              builder: (context, child) {
                return MultiBlocListener(
                  listeners: [
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        // Register AuthenticationBloc with global accessor
                        GlobalAuthenticationBlocAccessor.instance.registerAuthenticationBloc(
                          context.read<AuthenticationBloc>(),
                        );
                        
                        ///update company data at application initial event
                        final company = context.read<OnboardingBloc>().state.selectedCompany;
                        globalState.set(companyName, company?.companyName);
                        globalState.set(companyId, company?.id);
                        globalState.set(companyUrl, company?.url);
                        switch (state.status) {
                          case AuthenticationStatus.authenticated:
                            SharedUtil.getBoolValue(isDisclosure).then((isDisclosure) {
                              if (isDisclosure) {
                                _navigator.pushAndRemoveUntil(BottomNavigationPage.route(), (route) => false);
                              } else {
                                _navigator.pushAndRemoveUntil(AppPermissionPage.route(), (route) => false);
                              }
                            });
                            break;
                          case AuthenticationStatus.unauthenticated:
                            if (context.read<AuthenticationBloc>().state.data != null) {
                              _navigator.pushAndRemoveUntil(BottomNavigationPage.route(), (route) => false);
                            } else {
                              if (company == null) {
                                _navigator.pushAndRemoveUntil(OnboardingPage.route(), (_) => false);
                              } else {
                                _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
                              }
                            }
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                  ],
                  child: Stack(
                    children: [
                      child!,
                      // Global floating button overlay - managed by NavigatorObserver
                      ValueListenableBuilder<bool>(
                        valueListenable: GlobalVoiceButtonManager().isButtonVisible,
                        builder: (context, isVisible, _) {
                          if (!isVisible) {
                            return const SizedBox.shrink();
                          }
                          
                          return GlobalVoiceFloatingButton(
                            onPressed: () {
                              _navigator.pushNamed(Routes.voiceIO);
                            },
                            margin: const EdgeInsets.only(right: 16, bottom: 100),
                            backgroundColor: Theme.of(context).primaryColor,
                            icon: Icons.smart_toy,
                            showGreeting: true,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              theme: state.theme ?? initialTheme.copyWith(textTheme: GoogleFonts.robotoTextTheme()),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: Routes.initial,
              onGenerateRoute: generatedRoute().onGenerateRoute,
            );
          },
        );
      },
    );
  }
}

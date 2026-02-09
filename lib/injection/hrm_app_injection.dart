import 'dart:io';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart' as presentation;
import 'package:dio_service/app_injection.dart';
import 'package:domain/domain.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:notification/notification_injection.dart';
import 'package:offline_attendance/offline_attendance_app_injection.dart';
import 'package:offline_location/offline_location_app_injection.dart';
import 'package:strawberryhrm/presentation/app/hrm_app.dart';
import 'package:strawberryhrm/presentation/attendance/attendance_app_injection.dart';
import 'package:strawberryhrm/presentation/bottom_navigation/bottom_nav_app_injection.dart';
import 'package:strawberryhrm/presentation/break/break_back_injection.dart';
import 'package:strawberryhrm/presentation/daily_report/report_app_injection.dart';
import 'package:strawberryhrm/presentation/deduction/deduction_app_injection.dart';
import 'package:strawberryhrm/presentation/document/document_app_injection.dart';
import 'package:strawberryhrm/presentation/home/home_app_injection.dart';
import 'package:strawberryhrm/presentation/leave/leave_injection.dart';
import 'package:strawberryhrm/presentation/login/login_app_injection.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:strawberryhrm/presentation/onboarding/view/onboarding_page.dart';
import 'package:strawberryhrm/presentation/splash/view/not_found_screen.dart';
import 'package:strawberryhrm/presentation/travel/app_injection.dart';
import 'package:strawberryhrm/presentation/splash/splash_app_injection.dart';
import 'package:strawberryhrm/presentation/writeup/writeup_app_injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_io/voice_io.dart';

class HRMAppInjection {
  late FrameworkAppInjection _frameworkAppInjection;
  late MetaClubApiInjection _metaClubApiInjection;
  late HTTPServiceInjection _httpServiceInjection;
  late AuthenticationInjection _authenticationInjection;
  late DomainAppInjection _domainInjection;
  late UseCaseInjection _useCaseInjection;
  late HomeInjection _homeInjection;
  late BottomNavInjection _bottomNavInjection;
  late AttendanceInjection _attendanceInjection;
  late OfflineAttendanceInjection _offlineAttendanceInjection;
  late OfflineLocationInjection _offlineLocationInjection;
  late LocationTrackInjection _locationTrackInjection;
  late BreakBackInjection _breakBackInjection;
  late DocumentAppInjection _documentAppInjection;
  late WriteupAppInjection _writeupAppInjection;
  late TravelInjection _travelInjection;
  late ReportAppInjection _reportAppInjection;
  late SplashInjection _splashInjection;
  late RouteInjection _routeInjection;
  late NotificationInjection _notificationInjection;
  late DeductionInjection _deductionInjection;
  late LeaveInjection _leaveInjection;
  late LoginInjection _loginInjection;
  late VoiceIOInjection _voiceIOInjection;

  HRMAppInjection() {
    _frameworkAppInjection = FrameworkAppInjection();
    _metaClubApiInjection = MetaClubApiInjection();
    _httpServiceInjection = HTTPServiceInjection();
    _authenticationInjection = AuthenticationInjection();
    _domainInjection = DomainAppInjection();
    _useCaseInjection = UseCaseInjection();
    _homeInjection = HomeInjection();
    _bottomNavInjection = BottomNavInjection();
    _attendanceInjection = AttendanceInjection();
    _offlineAttendanceInjection = OfflineAttendanceInjection();
    _offlineLocationInjection = OfflineLocationInjection();
    _locationTrackInjection = LocationTrackInjection();
    _breakBackInjection = BreakBackInjection();
    _documentAppInjection = DocumentAppInjection();
    _writeupAppInjection = WriteupAppInjection();
    _splashInjection = SplashInjection();
    _routeInjection = RouteInjection();
    _travelInjection = TravelInjection();
    _reportAppInjection = ReportAppInjection();
    _travelInjection = TravelInjection();
    _reportAppInjection = ReportAppInjection();
    _splashInjection = SplashInjection();
    _routeInjection = RouteInjection();
    _notificationInjection = NotificationInjection();
    _deductionInjection = DeductionInjection();
    _leaveInjection = LeaveInjection();
    _loginInjection = LoginInjection();
    _voiceIOInjection = VoiceIOInjection();
  }

  Future<void> initInjection() async {
    ///---------------initial injection-------------------///
    final directory = await getApplicationDocumentsDirectory();
    //OnboardingBlocFactory
    instance.registerSingleton<OnboardingBlocFactory>(
      () => OnboardingBloc(metaClubApiClient: instance(), branding: instance(), brandingColorProvider: instance()),
    );
    //OnboardingPageFactory  
    instance.registerFactory<presentation.OnboardingPageFactory>(() => _OnboardingPageFactoryImpl());
    //OnboardingPageFactory typedef for route
    instance.registerFactory<OnboardingPageFactory>(() => () => const OnboardingPage());
    //VoiceScreenFactory
    instance.registerFactory<presentation.VoiceScreenFactory>(() => _VoiceScreenFactoryImpl());
    //NotFoundScreenFactory
    instance.registerFactory<presentation.NotFoundScreenFactory>(() => _NotFoundScreenFactoryImpl());
    
    // Note: BottomNavigationFactory, SplashScreenFactory, and LoginPageFactory 
    // are registered in their respective injection classes
    //AppFactory
    instance.registerFactory<AppFactory>(() => () => const HRMApp());

    instance.registerFactory<Directory>(() => directory);

    ///core injection
    await _httpServiceInjection.initInjection();
    await _frameworkAppInjection.initInjection();
    await _metaClubApiInjection.initInjection();
    await _authenticationInjection.initInjection();
    await _domainInjection.initInjection();
    await _useCaseInjection.initInjection();
    await _homeInjection.initInjection();
    
    // Register screen factories first
    await _bottomNavInjection.initInjection();
    await _splashInjection.initInjection();
    await _loginInjection.initInjection();
    
    // Then register route injection (which depends on screen factories)
    await _routeInjection.initInjection();
    await _attendanceInjection.initInjection();
    await _offlineAttendanceInjection.initInjection();
    await _offlineLocationInjection.initInjection();
    await _locationTrackInjection.initInjection();
    await _breakBackInjection.initInjection();
    await _documentAppInjection.initInjection();
    await _writeupAppInjection.initInjection();
    await _reportAppInjection.initInjection();
    await _travelInjection.initInjection();
    await _notificationInjection.initInjection();
    await _deductionInjection.initInjection();
    await _leaveInjection.initInjection();
    await _voiceIOInjection.initInjection();
  }
}

class _OnboardingPageFactoryImpl extends presentation.OnboardingPageFactory {
  @override
  Widget call() => const OnboardingPage();
}

class _VoiceScreenFactoryImpl extends presentation.VoiceScreenFactory {
  @override
  Widget call() => VoiceScreen.factory();
}

class _NotFoundScreenFactoryImpl extends presentation.NotFoundScreenFactory {
  @override
  Widget call() => const NotFoundScreen();
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';

class MockHomeDatLoadUseCase extends Mock implements HomeDataLoadUseCase{}

class MockSettingsDataLoadUseCase extends Mock implements SettingsDataLoadUseCase{}

class MockLogoutUseCase extends Mock implements LogoutUseCase{}

class MockEventBus extends Mock implements EventBus {}

class MockAttendanceRepository extends Mock implements OfflineAttendanceRepository{}

class MockHiveBox extends Mock implements Box{}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockMetaClubApiClientRepository extends Mock implements MetaClubApiClient {}

class MockSettings extends Mock implements Settings {}

class MockAuthenticationBloc extends MockBloc<AuthenticationEvent, AuthenticationState> implements AuthenticationBloc {}

class MockStorage extends Mock implements Storage {}

class MockFirebase extends Mock implements FirebaseApp {}

class MockHRMCoreBaseService extends Mock implements HRMCoreBaseService{}

class MockAuthenticationRepository extends Mock implements AuthenticationRepository{}

class MockOnboardingBloc extends Mock implements OnboardingBloc{}

class MockGlobalKey extends Mock implements GlobalKey<NavigatorState>{}

class MockStreamLocationUseCase extends Mock implements StreamLocationUseCase{}

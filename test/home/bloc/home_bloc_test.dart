import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/home/home.dart';
import '../../data/dummy.dart';
import '../../domain/usecases.dart';
import '../../main_test.dart';

main() {
  group('HomeBloc', () {
    late MockHomeDatLoadUseCase mockHomeDatLoadUseCase;
    late MockSettingsDataLoadUseCase mockSettingsDataLoadUseCase;
    late MockLogoutUseCase mockLogoutUseCase;
    late MockEventBus mockEventBus;
    late Settings settings;
    late StreamController<OfflineDataSycEvent> offlineStream;
    late HomeBloc homeBloc;
    late MockAttendanceRepository offlineAttendanceRepo;
    late MockStreamLocationUseCase mockStreamLocationUseCase;

    setUp(() async {
      initHiveDatabase();
      mockHomeDatLoadUseCase = MockHomeDatLoadUseCase();
      mockSettingsDataLoadUseCase = MockSettingsDataLoadUseCase();
      mockLogoutUseCase = MockLogoutUseCase();
      mockEventBus = MockEventBus();
      mockStreamLocationUseCase = MockStreamLocationUseCase();
      offlineAttendanceRepo = MockAttendanceRepository();
      offlineStream = StreamController<OfflineDataSycEvent>();
      settings = Settings.fromJson(settingJson);
      when(() => mockEventBus.on<OfflineDataSycEvent>()).thenAnswer((_) => offlineStream.stream);
      homeBloc = HomeBloc(
        logoutUseCase: mockLogoutUseCase,
        homeDatLoadUseCase: mockHomeDatLoadUseCase,
        settingsDataLoadUseCase: mockSettingsDataLoadUseCase,
        eventBus: mockEventBus,
        offlineAttendanceRepo: offlineAttendanceRepo,
        streamLocationUseCase: mockStreamLocationUseCase,
      );
    });

    group('initialize', () {
      blocTest(
        'should emit nothing',
        build: () {
          return homeBloc;
        },
        expect: () => [],
      );

      blocTest(
        'should emit correct state with settings',
        build: () {
          when(() => mockSettingsDataLoadUseCase()).thenAnswer((_) async => Right(settings));
          return homeBloc;
        },
        act: (HomeBloc bloc) => bloc.add(LoadSettings()),
        expect:
            () => [
              const HomeState(status: NetworkStatus.loading),
              HomeState(settings: settings, status: NetworkStatus.success),
            ],
      );
    });
  });
}

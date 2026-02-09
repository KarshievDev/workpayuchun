import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain/usecases.dart';

void main() async {
  late MockHiveBox mockHiveBox;
  late MockHiveInterface mockHiveInterface;

  setUpAll(() async {
    await initHydratedStorage();
    mockHiveBox = MockHiveBox();
    mockHiveInterface = MockHiveInterface();
    when(
      () => mockHiveInterface.openBox(any()),
    ).thenAnswer((_) async => mockHiveBox);
    EasyLocalization.logger.enableLevels = [];
  });

  // Widget buildLocalization({required Widget child}) {
  //   return EasyLocalization(
  //     supportedLocales: const [
  //       Locale('en', 'US'),
  //       Locale('bn', 'BN'),
  //       Locale('ar', 'AR'),
  //     ],
  //     path: 'assets/translations',
  //     saveLocale: true,
  //     fallbackLocale: const Locale('en', 'US'),
  //     child: child,
  //   );
  // }

  // group('HRM App Initialization', () {
  //
  //   setUp((){
  //     setupDependencyInjection();
  //   });
  //
  //   testWidgets('Render HRM AppView', (widgetTester) async {
  //     await widgetTester.pumpWidget(buildLocalization(child: const App()));
  //     expect(find.byType(AppView), findsOneWidget);
  //   });
  // });

  group('AppView', () {
    late AuthenticationBloc authBloc;

    setUp(() {
      authBloc = MockAuthenticationBloc();
      when(
        () => authBloc.state,
      ).thenReturn(const AuthenticationState.unknown());
      initHydratedStorage();
    });

    testWidgets('Render material theme', (tester) async {
      await tester.pumpWidget(const MaterialApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Material theme data check', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: Colors.blue),
          home: const Scaffold(),
        ),
      );

      ///In future we will implement theme and also test case
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
    });

    testWidgets('Material theme primary color will be blue', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: Colors.blue),
          home: const Scaffold(),
        ),
      );

      final theme = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme;

      expect(theme?.primaryColor, Colors.blue);
    });
  });
}

Future<void> initHydratedStorage() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final hydratedStorage = MockStorage();
  when(
    () => hydratedStorage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
  await EasyLocalization.ensureInitialized();
}

initHiveDatabase() async {
  initHydratedStorage();
}

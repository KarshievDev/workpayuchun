import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/home/home.dart';

main() {
  group('Home State Status', () {
    HomeState initialState = const HomeState();
    Settings settings = const Settings(result: true);
    DashboardModel dashboardModel = const DashboardModel(result: true);

    HomeState createSubject(
        {NetworkStatus status = NetworkStatus.initial,
        Settings? settings,
        DashboardModel? dashboardModel}) {
      return HomeState(status: status, settings: settings, dashboardModel: dashboardModel,isSwitched: true);
    }

    test('Return NetworkStatus.initial home state', () {
      const status = NetworkStatus.initial;
      expect(true, NetworkStatus.initial == status);
      expect(false, NetworkStatus.loading == status);
      expect(false, NetworkStatus.success == status);
    });
    test('Return NetworkStatus.loading home state', () {
      const status = NetworkStatus.loading;
      expect(false, NetworkStatus.initial == status);
      expect(true, NetworkStatus.loading == status);
      expect(false, NetworkStatus.success == status);
    });
    test('Return NetworkStatus.success home state', () {
      const status = NetworkStatus.success;
      expect(false, NetworkStatus.initial == status);
      expect(false, NetworkStatus.loading == status);
      expect(true, NetworkStatus.success == status);
    });

    test('Support State equality', () {
      expect(const HomeState(), equals(const HomeState()));
    });

    test('Support value equality', () {
      expect(const HomeState().props, equals(initialState.props));
    });

    test('Props are correct', () {
      expect(
          createSubject(
                  status: NetworkStatus.success,
                  settings: settings,
                  dashboardModel: dashboardModel).props,
          equals(<Object>[settings, dashboardModel, NetworkStatus.success,true]));
    });
  });
}

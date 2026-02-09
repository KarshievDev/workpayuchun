import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';

class HomeInjection {
  Future<void> initInjection() async {
    instance.registerFactory<HomeBlocFactory>(
      () => () {
        final homeBloc = HomeBloc(
          logoutUseCase: instance(),
          homeDatLoadUseCase: instance(),
          settingsDataLoadUseCase: instance(),
          eventBus: instance(),
          offlineAttendanceRepo: instance(),
          streamLocationUseCase: instance(),
        );

        // Register with global accessor
        GlobalHomeBlocAccessor.instance.registerHomeBloc(homeBloc);

        return homeBloc;
      },
    );
  }
}

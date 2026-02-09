import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';

class BreakBackInjection {
  Future<void> initInjection() async {
    instance.registerFactory<BreakBlocFactory>(() => () => BreakBloc(
        breakBackUseCase: instance(),
        breakBackHistoryUseCase: instance(),
        breakBackQRVerifyUseCase: instance(),
        submitRemarksUseCase: instance()));
  }
}

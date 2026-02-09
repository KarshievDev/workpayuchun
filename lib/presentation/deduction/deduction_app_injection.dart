import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/deduction/view/deduction_screen.dart';
import 'bloc/deduction/deduction_cubit.dart';

class DeductionInjection {
  Future<void> initInjection() async {
    instance.registerFactory<DeductionCubitFactory>(() => () => DeductionCubit(loadDeductionUseCase: instance(), submitDeductionAppealUseCase: instance()));
    instance.registerFactory<DeductionScreenFactory>(() => () => DeductionScreen(deductionCubit: instance()));
  }
}

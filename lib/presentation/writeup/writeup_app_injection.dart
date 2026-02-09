import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'bloc/verbal_wraning/verbal_warning_bloc.dart';

class WriteupAppInjection {
  Future<void> initInjection() async {
    instance.registerFactory<ComplainBlocFactory>(() => () => ComplainBloc(
        loadComplainUseCase: instance(),
        submitComplainUseCase: instance(),
        loadComplainRepliesUseCase: instance(),
        submitComplainReplyUseCase: instance()));
    instance.registerFactory<VerbalWarningBlocFactory>(
        () => () => VerbalWarningBloc(loadComplainUseCase: instance(), submitComplainUseCase: instance()));
  }
}

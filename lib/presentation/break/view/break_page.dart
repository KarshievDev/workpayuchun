import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import '../bloc/break_bloc.dart';
import 'content/break_content.dart';

class BreakScreen extends StatelessWidget {
  final bool withQR;
  final BreakBloc? breakBloc;

  const BreakScreen({super.key, this.withQR = false, this.breakBloc});

  static Route route({required HomeBloc homeBloc, BreakBloc? breakBloc, bool withQR = false}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(value: homeBloc, child: BreakScreen(withQR: withQR, breakBloc: breakBloc)));
  }

  @override
  Widget build(BuildContext context) {
    final breakBackBloc = instance<BreakBlocFactory>();
    return withQR
        ? BlocProvider.value(value: breakBloc!, child:BreakContent(homeBloc: context.read<HomeBloc>()))
        : BlocProvider(
            create: (context) => breakBackBloc()..add(GetBreakHistoryData()),
            child: BreakContent(homeBloc: context.read<HomeBloc>()),
          );
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/bottom_navigation/bloc/bottom_nav_cubit.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import '../content/bottom_nav_content.dart';
import 'package:presentation/presentation.dart' as presentation;

class BottomNavigationPage extends StatelessWidget {
  final HomeBlocFactory homeBlocFactor;

  const BottomNavigationPage({super.key, required this.homeBlocFactor});

  static Route route() {
    final bottomNavigationFactory = instance<presentation.BottomNavigationFactory>();
    return MaterialPageRoute(builder: (_) => bottomNavigationFactory());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider<HomeBloc>(
          create: (_) => homeBlocFactor()
            ..add(LoadSettings())
            ..add(LoadHomeData()),
        ),
      ],
      child: const BottomNavContent(),
    );
  }
}

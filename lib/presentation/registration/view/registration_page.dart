import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../bloc/registration_bloc.dart';
import '../cubit/country_cubit.dart';
import '../cubit/qualification_cubit.dart';
import 'content/registration_content.dart';

class RegistrationPage extends StatefulWidget {
  static get route =>
      MaterialPageRoute(builder: (_) => const RegistrationPage());

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QualificationCubit>(create: (_) => QualificationCubit()),
        BlocProvider<CountryCubit>(create: (_) => CountryCubit()),
        BlocProvider<RegistrationBloc>(create: (_) => RegistrationBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(RegistrationInitialRequest()))
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Registration'),
          backgroundColor: mainColor,
          automaticallyImplyLeading: true,
          centerTitle: false,
        ),
        body: const RegistrationContent(),
      ),
    );
  }
}

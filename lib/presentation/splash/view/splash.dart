import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/animation/bounce_animation/bounce_animation_builder.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:strawberryhrm/presentation/splash/bloc/splash_bloc.dart';

typedef SplashScreenFactory = SplashScreen Function();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final selectedCompany = context.read<OnboardingBloc>().state.selectedCompany;

    return BlocProvider(
      create: (context) => SplashBloc(data: user, selectedCompany: selectedCompany),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BounceAnimationBuilder(
                  builder: (_, __) {
                    return Center(
                      child: InteractiveViewer(
                        scaleEnabled: false,
                        boundaryMargin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Image.asset(
                          key: const ValueKey('SPLASH_LOGO'),
                          "assets/images/app_icon.png",
                          scale: 3,
                        ),
                      ),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const HomeContent();
  }
}

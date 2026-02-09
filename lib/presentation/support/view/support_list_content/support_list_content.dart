import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/support/content/bar_status_widget.dart';
import 'package:strawberryhrm/presentation/support/content/support_list_widget.dart';

class SupportListContent extends StatelessWidget {
  const SupportListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        BarStatusWidget(),
        SupportListWidget()
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(5)),
      child: const Text(
        "Details",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green),
      ),
    );
  }
}

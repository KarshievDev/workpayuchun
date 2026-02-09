import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AppealButton extends StatelessWidget {
  final Deduction? deduction;

  const AppealButton({super.key, this.deduction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          border: Border.all(color: deduction?.appealEnable == 0 ? Colors.red : Colors.green),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        "Appeal",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: deduction?.appealEnable == 0 ? Colors.red : Colors.green),
      ),
    );
  }
}

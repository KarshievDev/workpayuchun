import 'package:flutter/material.dart';

class DeductionInfoLeftWidget extends StatelessWidget {
  final bool? isAppeal;
  const DeductionInfoLeftWidget({super.key,this.isAppeal = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Month", style: TextStyle(color: Colors.black, fontSize: 12)),
        const SizedBox(height: 8),
        const Text("Amount", style: TextStyle(color: Colors.black, fontSize: 12)),
        const SizedBox(height: 8),
        const Text("Consider Amount", style: TextStyle(color: Colors.black, fontSize: 12)),
        const SizedBox(height: 8),
        const Text("Is Appealed", style: TextStyle(color: Colors.black, fontSize: 12)),
        Visibility(
          visible: isAppeal ?? true,
          child: const Column(
            children: [
              SizedBox(height: 12),
              Text("Apply for Appeal", style: TextStyle(color: Colors.black, fontSize: 12)),
              SizedBox(height: 12),
              Text("Deduction Details", style: TextStyle(color: Colors.black, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

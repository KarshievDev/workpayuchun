import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class DeductionDetailsCard extends StatelessWidget {
  final DeductionDetails? deductionDetailsItem;

  const DeductionDetailsCard({super.key, this.deductionDetailsItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deduction Purpose", style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(height: 8),
                  Text("Deduction Type", style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(height: 8),
                  Text("Deduction Amount", style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(height: 8),
                  Text("Deduction Day", style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(height: 8),
                  Text("Deduction Applicable", style: TextStyle(color: Colors.black, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 140, child: VerticalDivider(width: 20, thickness: 1, color: Colors.black)),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deductionDetailsItem?.purpose ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deductionDetailsItem?.deductionType ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deductionDetailsItem?.amount ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deductionDetailsItem?.days.toString() ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deductionDetailsItem?.isApplicable ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

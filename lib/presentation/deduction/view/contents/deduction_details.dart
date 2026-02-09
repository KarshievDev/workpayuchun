import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/deduction_details_card.dart';

class DeductionDetailsPage extends StatelessWidget {
  final List<DeductionDetails>? deductionDetails;

  const DeductionDetailsPage({super.key, this.deductionDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Deduction Details",
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: deductionDetails?.length ?? 0,
          itemBuilder: (context, index) {
            DeductionDetails? deductionDetailsItem = deductionDetails?[index];
            return DeductionDetailsCard(deductionDetailsItem: deductionDetailsItem);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 40);
          },
        ));
  }
}

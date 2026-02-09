import 'package:flutter/material.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class ExpenseListShimmer extends StatelessWidget {
  const ExpenseListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

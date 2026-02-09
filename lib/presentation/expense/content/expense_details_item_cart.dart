import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseDetailsItemCart extends StatelessWidget {
  const ExpenseDetailsItemCart({super.key, this.title, this.value});

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0).r,
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title ?? '',
                style:  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.r),
              )),
              Text(value ?? '', style:  TextStyle(fontSize: 14.r)),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

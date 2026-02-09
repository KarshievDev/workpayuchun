import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioTile extends StatelessWidget {
  final Function(String?) onChanged;
  final String title;
  final String? initialData;

  const CustomRadioTile(
      {super.key,
      required this.onChanged,
      required this.title,
      required this.initialData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<String>(value: title, groupValue: initialData, onChanged: onChanged),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 12.r),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DailyLeaveStatusWidget extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? count;

  const DailyLeaveStatusWidget({super.key, this.color, this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(100)),
            child: const SizedBox(),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title ?? "",
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          const Spacer(),
          Text(count ?? "")
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:core/core.dart';
import '../../bloc/meeting_bloc.dart';

class MeetingNameList extends StatelessWidget {
  const MeetingNameList({
    super.key,
    required this.state,
  });

  final MeetingState? state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
          children: List.generate(
              state?.selectedNames.length ?? 0,
              (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00CCFF),
                          colorPrimary,
                        ],
                        begin: FractionalOffset(2.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Text(
                    state?.selectedNames[index] ?? "",
                    style: TextStyle(
                        fontSize: 12.r,
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )))),
    );
  }
}

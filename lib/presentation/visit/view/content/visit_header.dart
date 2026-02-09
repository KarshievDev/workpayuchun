import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';

class VisitHeader extends StatelessWidget {
  const VisitHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        VisitDetailsResponse? data = state.visitDetailsResponse?.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(data?.date ?? "", style: TextStyle(fontSize: 12.r)),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(int.parse(data?.statusColor ?? "0xFFFE8E63")),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      color: Color(int.parse(data?.statusColor ?? "0xFFFE8E63")),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DottedBorder(
                      color: Colors.white,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      strokeWidth: 1,
                      child:
                          Text(
                            data?.status ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 10.r, fontWeight: FontWeight.w600),
                          ).tr(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(data?.title ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.r)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(data?.description ?? "", style: TextStyle(fontSize: 12.r, color: Colors.grey)),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LeaveTypeContent extends StatelessWidget {
  const LeaveTypeContent({
    super.key,
    required this.data,
  });

  final ApprovalDetailsData? data;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.labelSmall;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0).r,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('leave_type',
                              style: textStyle!
                                  .copyWith(color: const Color(0xFF6B6A70), fontSize: 12.r))
                          .tr(),
                      Chip(
                        label: Text(data?.type ?? '', style: textStyle.copyWith(fontSize: 10.r)),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('leave_status',
                              style: textStyle.copyWith(
                                  color: const Color(0xFF6B6A70), fontSize: 12.r))
                          .tr(),
                      Chip(
                        backgroundColor: Color(
                          int.parse(data?.colorCode ?? "0.0"),
                        ),
                        label: Text(
                          data?.status ?? '',
                          style: textStyle.copyWith(color: Colors.white, fontSize: 10.r),
                        ).tr(),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('form_-_to',
                              style: textStyle.copyWith(
                                  color: const Color(0xFF6B6A70), fontSize: 12.r))
                          .tr(),
                      Chip(
                        label: Text(data?.period ?? '', style: textStyle.copyWith(fontSize: 10.r)),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('leave_balance',
                              style: textStyle.copyWith(
                                  color: const Color(0xFF6B6A70), fontSize: 12.r))
                          .tr(),
                      Chip(
                        label: Text(
                            '${data?.totalUsed} / ${data?.availableLeave} Days',
                            style: textStyle.copyWith(fontSize: 10.r)),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/leave_report/leave_report.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class LeaveInfoContent extends StatelessWidget {
  const LeaveInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveBloc = context.watch<LeaveReportBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leaveBloc.state.filterLeaveSummaryResponse != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width:10.r,
                              height: 10.r,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tr('total_leaves'),
                              style: TextStyle(
                                  fontSize: 12.r , color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          leaveBloc.state.filterLeaveSummaryResponse
                                  ?.leaveSummaryData?.totalLeave
                                  .toString() ??
                              '0',
                          style: TextStyle(
                              fontSize: 25.r, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.r,
                              height: 10.0.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4358BE),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tr("leaves_used"),
                              style: TextStyle(
                                  fontSize: 12.r, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          leaveBloc.state.filterLeaveSummaryResponse
                                  ?.leaveSummaryData?.totalUsed
                                  .toString() ??
                              '0',
                          style: TextStyle(
                              fontSize: 25.r, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            :  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height: 65.h ,
                      width: 150.w,
                    ),
                    const Spacer(),
                    RectangularCardShimmer(
                      height: 65.h,
                      width: 150.w ,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 25,
        ),
        leaveBloc.state.filterLeaveSummaryResponse?.leaveSummaryData
                    ?.availableLeave?.isNotEmpty ==
                true
            ? const LeaveInfoListTile()
            :  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height:55.r,
                      width: 100.r ,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RectangularCardShimmer(
                      height:55.r,
                      width: 100.r ,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

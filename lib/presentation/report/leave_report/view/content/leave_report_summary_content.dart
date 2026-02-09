import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/leave_report/leave_report.dart';
import 'package:strawberryhrm/presentation/report/report.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class LeaveReportSummaryContent extends StatelessWidget {
  const LeaveReportSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveReportBloc, LeaveReportState>(
        builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8).r,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0).r,
                child: ListTile(
                    leading: Text(
                      state.leaveReportSummaryModel?.data?.date ?? '',
                      style: TextStyle(fontSize: 14.r),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<LeaveReportBloc>()
                            .add(SelectDatePicker(context));
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        size: 24.r,
                      ),
                    )),
              ),
            ),
          ),
          state.leaveReportSummaryModel != null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: state.leaveReportSummaryModel?.data?.leaveTypes
                                ?.isNotEmpty ==
                            true
                        ? ListView.builder(
                            itemCount: state.leaveReportSummaryModel?.data
                                    ?.leaveTypes?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.leaveReportSummaryModel?.data
                                  ?.leaveTypes?[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 4)
                                      .r,
                                  child: ListTile(
                                    onTap: () {
                                      NavUtil.navigateScreen(
                                        context,
                                        BlocProvider.value(
                                          value:
                                              context.read<LeaveReportBloc>(),
                                          child: LeaveTypeWiseSummary(
                                              leaveData: data!),
                                        ),
                                      );
                                    },
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      tr(data?.name ?? ''),
                                      style: TextStyle(
                                        fontSize: 14.r,
                                        color: Colors.black.withValues(alpha: 0.7),
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        data?.count.toString() ?? '',
                                        style: TextStyle(
                                            fontSize: 14.r,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: NoDataFoundWidget(
                            title: "no_data_found",
                          )),
                  ),
                )
              : Expanded(child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return const TileShimmer();
                  },
                )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimary, shape: const StadiumBorder()),
            onPressed: () {
              NavUtil.navigateScreen(
                  context,
                  BlocProvider.value(
                      value: context.read<LeaveReportBloc>(),
                      child: const EmployeeLeaveHistory()));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16),
              child: Text(
                tr('search_all'),
                style: TextStyle(color: Colors.white, fontSize: 16.r),
              ),
            ),
          ),
        ],
      );
    });
  }
}

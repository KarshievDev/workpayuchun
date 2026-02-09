import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/build_container.dart';

import '../../../report.dart';

class LeaveSummaryDetails extends StatelessWidget {
  final int leaveId;
  final int userId;

  const LeaveSummaryDetails(
      {super.key, required this.leaveId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("leave_details".tr())),
      body: FutureBuilder(
        future: context
            .read<LeaveReportBloc>()
            .onLeaveSummaryDetails(userId, leaveId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final leaveReportData = snapshot.data?.leaveDetailsData;
            return Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 130, child: Text(tr("status"))),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(int.parse(
                              leaveReportData?.colorCode ?? "0xFFFFFF")),
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        color:
                            Color(int.parse(leaveReportData?.colorCode ?? "")),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DottedBorder(
                        color: Colors.white,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        strokeWidth: 1,
                        child: Text(
                          '${leaveReportData?.status?.status}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BuildContainer(
                  title: tr("requested_on"),
                  titleValue: leaveReportData?.requestedOn ?? ""),
              BuildContainer(
                  title: tr("type"), titleValue: leaveReportData?.type ?? ""),
              BuildContainer(
                  title: tr("period"),
                  titleValue: leaveReportData?.period ?? ""),
              BuildContainer(
                  title: tr("total_days"),
                  titleValue:
                      '${leaveReportData?.totalDays ?? ""} ${tr("days")}'),
              BuildContainer(
                title: tr("note"),
                titleValue: leaveReportData?.note ?? "",
              ),
              BuildContainer(
                title: tr("substitute"),
                titleValue: leaveReportData?.name ?? tr("add_substitute"),
              ),
              BuildContainer(
                title: tr("approves"),
                titleValue: leaveReportData?.apporover,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 130, child: Text(tr("attachment"))),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              )
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

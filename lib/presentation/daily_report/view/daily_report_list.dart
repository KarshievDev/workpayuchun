import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/view/create_daily_report_page.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/travel/travel_plan_view/content/floating_button.dart';

class DailyReportListScreen extends StatelessWidget {
  const DailyReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: FloatingButton(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: context.read<DailyReportBloc>(), child: const CreateDailyReportPage())));
        },
      ),
      appBar: AppBar(
        title: const Text(
          "Daily Report List",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocBuilder<DailyReportBloc, DailyReportState>(
        builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: GeneralListShimmer());
          } else if (state.status == NetworkStatus.success) {
            List<UserDailyReport>? dailyReportList = state.dailyReportListModel?.data?.data;
            return dailyReportList?.isNotEmpty == true
                ? ListView.separated(
                    itemCount: dailyReportList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      UserDailyReport? dailyReport = dailyReportList?[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                        child: Card(
                          color: Colors.white,
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Employee",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Date",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Start Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "End Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Total Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Calls Made",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Positive Leads",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Total Sales",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "How Was your day",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.employee?.name ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.date ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.startTime ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.endTime ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.totalTime ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.callsMade.toString() ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.positiveLeads.toString() ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.totalSales ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": ${dailyReport?.howWasYourDayMark.toString() ?? ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Branding.colors.primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                  )
                : const NoDataFoundWidget();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

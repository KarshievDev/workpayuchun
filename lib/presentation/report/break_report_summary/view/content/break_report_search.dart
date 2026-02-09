import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/report/break_report_summary/break_report.dart';
import 'package:strawberryhrm/presentation/select_employee/view/select_employee.dart';
import 'package:core/core.dart';

class BreakReportSearch extends StatelessWidget {
  const BreakReportSearch({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BreakBloc>().add(BreakSummaryDetails());
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (BuildContext context, state) {
        final reportBreakData =
            state.reportBreakListModel?.data?.breakHistory?.todayHistory;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
            child: AppBar(
              iconTheme:  IconThemeData(
                  size: DeviceUtil.isTablet ? 40 : 30,
                  color: Colors.white
              ),
              title: Text(tr('break_time_report'),style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<BreakBloc>().add(SelectDate(context, true));
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.r),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectEmployeePage(),
                          )).then((value) {
                        if (value != null && context.mounted) {
                          context.read<BreakBloc>().add(SelectEmployee(value));
                        }
                      });
                    },
                    title: Text(context.watch<BreakBloc>().state.selectEmployee?.name! ?? 'select_employee',style: TextStyle(fontSize: 14.r ),).tr(),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(context
                              .watch<BreakBloc>()
                              .state
                              .selectEmployee
                              ?.avatar ??
                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                    ),
                    trailing: Icon(Icons.search,size: 24.r,),
                  ),
                ),
              ),
              Container(
                color: const Color(0xff6AB026),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 22.r,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${tr('total_break_time')}:",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 14.r, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      state.reportBreakListModel?.data?.totalBreakTime ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.r,
                          fontWeight: FontWeight.w500,
                          fontFamily: "digitalNumber"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              reportBreakData?.isNotEmpty == true
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reportBreakData?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = reportBreakData?[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: DeviceUtil.isTablet ? 100.w : 100,
                                      child: Text(
                                        data?.breakTimeDuration ?? '',
                                        textAlign: TextAlign.center,style: TextStyle(fontSize: 14.r),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40.h,
                                      width:  3.r,
                                      color: colorPrimary,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                         Text(
                                          "break",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                          fontSize: 14.r),
                                        ).tr(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(data?.breakBackTime ?? '',style: TextStyle(fontSize: 12.r ),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const NoDataFoundWidget()
            ],
          ),
        );
      },
    );
  }
}

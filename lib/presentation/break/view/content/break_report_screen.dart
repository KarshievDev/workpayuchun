import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';

class BreakReportScreen extends StatelessWidget {
  const BreakReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80.0 : 50),
            child: AppBar(
              iconTheme: IconThemeData(size: 20.r, color: Colors.white),
              title: Text(tr("break_time_report"),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor, fontSize: 16.r))
                  .tr(),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<BreakBloc>().add(SelectDatePicker(context));
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                color: const Color(0xff6AB026),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: DeviceUtil.isTablet ? 10.h : 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 20.r,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      tr("total_break_time"),
                      style: GoogleFonts.nunitoSans(fontSize: 16.r, color: Colors.white),
                    ),
                    SizedBox(
                      width: DeviceUtil.isTablet ? 5.w : 5,
                    ),
                    Text(
                      state.breakReportModel?.data?.totalBreakTime ?? "00:00:00",
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
                height: 16.0,
              ),
              if (state.breakReportModel != null)
                state.breakReportModel!.data!.breakHistory?.todayHistory?.isNotEmpty == true
                    ? Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      state.breakReportModel?.data?.breakHistory?.todayHistory?[index]
                                              .breakTimeDuration ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14.r),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: DeviceUtil.isTablet ? 60 : 40,
                                    width: DeviceUtil.isTablet ? 5 : 3,
                                    color: colorPrimary,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.breakReportModel?.data?.breakHistory?.todayHistory?[index].reason ?? "",
                                        style:
                                            TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
                                      ).tr(),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        state.breakReportModel?.data?.breakHistory?.todayHistory?[index]
                                                .breakBackTime ??
                                            "",
                                        style: TextStyle(fontSize: 14.r),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: state.breakReportModel?.data?.breakHistory?.todayHistory?.length ?? 0),
                      )
                    : const Expanded(child: NoDataFoundWidget())
            ],
          ),
        );
      },
    );
  }
}

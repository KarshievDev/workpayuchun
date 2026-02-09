import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/leave_report/leave_report.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LeaveInfoListTile extends StatelessWidget {
  const LeaveInfoListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveAvailable = context
        .watch<LeaveReportBloc>()
        .state
        .filterLeaveSummaryResponse
        ?.leaveSummaryData
        ?.availableLeave;
    return Visibility(
      visible: leaveAvailable?.isNotEmpty ?? false,
      child: SizedBox(
        height: DeviceUtil.isTablet ?  100.h : 100,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: leaveAvailable?.length ?? 0,
            itemBuilder: (context, index) {
              final data = leaveAvailable?[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55.h,
                      width: 60.w,
                      child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum:100.h ,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            axisLineStyle:  AxisLineStyle(
                              thickness: 0.1.r ,
                              color: const Color(0xFFE8E8E9),
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                  value: data?.leftDays?.toDouble() ?? 0,
                                  width: 0.1.r,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFF4358BE),
                                  cornerStyle: CornerStyle.bothCurve),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(data?.leftDays.toString() ?? "0",
                                    style:  TextStyle(
                                        fontSize: 20.r,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF414F5D))),
                                positionFactor: 0,
                                axisValue: 70,
                              )
                            ])
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(data?.type ?? "sick",
                            style: TextStyle(
                                fontSize: 12.r, color: Colors.grey))
                        .tr(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

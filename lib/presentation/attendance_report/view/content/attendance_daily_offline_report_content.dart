import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offline_attendance/domain/offline_attendance_repository.dart';
import 'offline_present_content.dart';

class AttendanceDailyOfflineReportContent extends StatelessWidget {

  const AttendanceDailyOfflineReportContent({super.key});

  @override
  Widget build(BuildContext context) {

    final futureData = instance<OfflineAttendanceRepository>().getAllOfflineCheckData();
    final eventBus = instance<EventBus>();

    return StreamBuilder(
      stream: eventBus.on<OnOnlineAttendanceUpdateEvent>(),
      builder: (context,snapshot){
        return FutureBuilder(future: futureData, builder: (context,snapshot){
          if(snapshot.hasData){
            final data = snapshot.data;
            return data!.isNotEmpty ? Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(
                    tr("daily_report"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.r),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final attendance = data[index];
                      return DailyOfflineReportTile(dailyReport: attendance);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ): const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        });
      },
    );
  }
}

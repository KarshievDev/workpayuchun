import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/attendance_report_summary/view/content/attendance_summary/attendance_summary.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

import '../../../bloc/report_bloc.dart';

class BodyToListDetails extends StatelessWidget {
  const BodyToListDetails({super.key, required this.title, required this.type});

  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    final reportBloc = context.read<ReportBloc>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
        child: AppBar(
          iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30,   color: Colors.white),
          title: Text('attendance_$title',style: TextStyle(fontSize: 16.sp),).tr(),
        ),
      ),
      body: FutureBuilder(
        future: reportBloc.getSummaryToList(type: type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                snapshot.data?.data?.users?.isNotEmpty == true
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.data?.users?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = snapshot.data?.data?.users?[index];
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    NavUtil.navigateScreen(context,
                                      BlocProvider.value(
                                        value: context.read<ReportBloc>(),
                                        child: ProfileDetails(userId: data!.userId!),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage('${data?.avatar}'),
                                  ),
                                  title: Text(data?.name ?? '',
                                    style: TextStyle(fontSize: 14.r)
                                  ),
                                  subtitle: Text(data?.designation ?? '',
                                      style: TextStyle(fontSize: 12.r)),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data?.checkIn ?? '',
                                        style: Theme.of(context).textTheme.titleMedium!
                                            .copyWith(color: Colors.green,fontSize: DeviceUtil.isTablet ? 8.sp : 10),
                                      ),
                                      Text(data?.checkOut ?? '',
                                        style: TextStyle(color: Colors.red,fontSize: DeviceUtil.isTablet ? 8.sp : 10),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Expanded(child: Center(child: NoDataFoundWidget())),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

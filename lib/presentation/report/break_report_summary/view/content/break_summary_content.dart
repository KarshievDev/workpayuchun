import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/break_report_summary/break_report.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class BreakSummaryContent extends StatelessWidget {
  const BreakSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (BuildContext context, state) {
        final breakList = state.breakSummaryModel?.data?.employeeList;
        if (state.breakSummaryModel != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      state.breakSummaryModel?.data?.date ?? '',
                      style: TextStyle(fontSize: 14.r),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<BreakBloc>()
                            .add(SelectDate(context, false));
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        size: 22.r,
                      ))
                ],
              ),
              breakList?.isNotEmpty == true
                  ? Expanded(
                      child: ListView.builder(
                      itemCount: breakList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = breakList?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Card(
                            child: ListTile(
                              onTap: () => NavUtil.navigateScreen(
                                context,
                                BlocProvider.value(
                                  value: context.read<BreakBloc>(),
                                  child: BreakReportList(
                                    breakUserId: data!.userId.toString(),
                                  ),
                                ),
                              ),
                              leading: ClipOval(
                                child: Image.network(
                                  data?.avatarId ??
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              title: Text(
                                data?.name ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(data?.designation ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.r)),
                              trailing: Text(
                                data?.totalBreakTime ?? '',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.r),
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  : const Expanded(child: NoDataFoundWidget()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Card(
                  elevation: 4,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      NavUtil.navigateScreen(
                          context,
                          BlocProvider.value(
                              value: context.read<BreakBloc>(),
                              child: const BreakReportSearch()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20.r,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            tr('search_all_break_report'),
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.r),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(DeviceUtil.isTablet ? 8.0.r : 8.0),
              child: const TileShimmer(
                isSubTitle: true,
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/content/hitory_item.dart';
import 'package:core/core.dart';

class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.read<VisitBloc>().add(SelectMonthPickerEvent(context));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, color: colorPrimary, size: 22.r),
              SizedBox(width: 5.w),
              Text("select_month".tr(), style: TextStyle(fontSize: 12.r, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        BlocBuilder<VisitBloc, VisitState>(
          builder: (BuildContext context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: GeneralListShimmer());
            } else if (state.status == NetworkStatus.success) {
              return state.historyListResponse?.data?.history?.isNotEmpty == true
                  ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.historyListResponse?.data?.history?.length ?? 0,
                    itemBuilder: (context, index) {
                      History? myHistoryList = state.historyListResponse?.data?.history?[index];

                      return HistoryItem(myHistoryList: myHistoryList);
                    },
                  )
                  : const Expanded(child: NoDataFoundWidget());
            } else if (state.status == NetworkStatus.failure) {
              return Center(
                child: Text(
                  "ailed_to_load_visit_history".tr(),
                  style: TextStyle(color: colorPrimary.withValues(alpha: 0.4), fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

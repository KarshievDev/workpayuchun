import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_list_item.dart';
import 'package:core/core.dart';

class VisitListPage extends StatelessWidget {
  const VisitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (BuildContext context, state) {
        if (state.status == NetworkStatus.loading) {
          return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: GeneralListShimmer());
        } else if (state.status == NetworkStatus.success) {
          return state.visitListResponse?.visitList?.myVisits?.isNotEmpty == true
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: state.visitListResponse?.visitList?.myVisits?.length ?? 0,
                  itemBuilder: (context, index) {
                    MyVisit? myVisit = state.visitListResponse?.visitList?.myVisits?[index];
                    return VisitListItem(myVisit: myVisit);
                  },
                ),
              )
              : const NoDataFoundWidget();
        } else if (state.status == NetworkStatus.failure) {
          return Center(
            child: Text(
              "failed_to_load_visit".tr(),
              style: TextStyle(color: colorPrimary.withValues(alpha: 0.4), fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

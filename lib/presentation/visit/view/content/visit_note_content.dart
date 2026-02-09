import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../bloc/visit_bloc.dart';
import '../visit_note_page/visit_note_page.dart';

class VisitNoteContent extends StatelessWidget {
  final int visitID;

  const VisitNoteContent({super.key, required this.visitID});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Text(
            tr("visit_notes"),
            style:  TextStyle(fontSize: 12.r, fontWeight: FontWeight.bold),
          ),
        ),
        BlocBuilder<VisitBloc, VisitState>(
          builder: (BuildContext context, state) {
            if (state.status == NetworkStatus.loading) {
              return const SizedBox();
            } else if (state.status == NetworkStatus.success) {
              return state.visitListResponse?.visitList?.myVisits?.isNotEmpty ==
                      true
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          state.visitDetailsResponse?.data?.notes?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.visitDetailsResponse?.data?.notes?[index]
                                        .note ??
                                    "",
                                style:  TextStyle(
                                    fontSize: 10.r, color: Colors.black45),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                          color: Colors.black12,
                        );
                      },
                    )
                  : const NoDataFoundWidget();
            } else if (state.status == NetworkStatus.failure) {
              return Center(
                child: Text(
                  "failed_to_load_leave_list".tr(),
                  style: TextStyle(
                      color: colorPrimary.withValues(alpha: 0.4),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        InkWell(
          onTap: () {
            NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<VisitBloc>(),
                    child: VisitNotePage(
                      visitID: visitID,
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10).r,
                child: Row(
                  children: [
                    Text(
                      tr("visit_notes"),
                      style:  TextStyle(
                          fontSize: 12.r, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

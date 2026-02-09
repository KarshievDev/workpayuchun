import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/notice_list/bloc/notice_list_bloc.dart';
import 'package:strawberryhrm/presentation/notice_list/content/notice_list_content.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationListBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(LoadNotificationListData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("notice"),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: BlocBuilder<NotificationListBloc, NoticeListState>(builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == NetworkStatus.success) {
            if (state.noticeListModel != null) {
              return Column(
                children: [
                  state.noticeListModel?.data?.notices?.data?.isNotEmpty == true
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: state.noticeListModel?.data?.notices?.data?.length ?? 0,
                            separatorBuilder: (BuildContext context, int index) => const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.noticeListModel?.data?.notices?.data?[index];
                              return NoticeListContent(data: data);
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(child: NoDataFoundWidget()),
                        )
                  // : const SizedBox(),
                ],
              );
            }
          }
          if (state.status == NetworkStatus.failure) {
            return Center(child: Text('failed_to_load_notification'.tr()));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

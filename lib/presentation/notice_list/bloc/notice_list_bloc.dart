import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'notice_list_event.dart';

part 'notice_list_state.dart';

class NotificationListBloc extends Bloc<NoticeListEvent, NoticeListState> {
  final MetaClubApiClient _metaClubApiClient;

  NotificationListBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const NoticeListState(
          status: NetworkStatus.initial,
        )) {
    on<LoadNotificationListData>(_onNoticeListDataLoad);
    on<ClearNoticeButton>(_onClearData);
  }

  void _onNoticeListDataLoad(LoadNotificationListData event, Emitter<NoticeListState> emit) async {
    emit(const NoticeListState(status: NetworkStatus.loading));
    final noticeListModel = await _metaClubApiClient.getNoticeList();
    noticeListModel.fold((l) {
      emit(const NoticeListState(status: NetworkStatus.failure));
    }, (r) {
      emit(state.copy(noticeListModel: r, status: NetworkStatus.success));
    });
  }

  void _onClearData(ClearNoticeButton event, Emitter<NoticeListState> emit) async {
    await _metaClubApiClient.clearAllNotificationApi();
  }
}

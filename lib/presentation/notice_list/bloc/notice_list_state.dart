part of 'notice_list_bloc.dart';

class NoticeListState extends Equatable {
  final NoticeListModel? noticeListModel;
  final NetworkStatus status;
  final String? slugName;

  const NoticeListState(
      {this.noticeListModel,
      this.slugName,
      this.status = NetworkStatus.initial});

  NoticeListState copy(
      {BuildContext? context,
      NoticeListModel? noticeListModel,
      String? slugName,
      NetworkStatus? status}) {
    return NoticeListState(
        noticeListModel: noticeListModel,
        status: status ?? this.status,
        slugName: slugName ?? this.slugName);
  }

  @override
  List<Object?> get props => [noticeListModel, slugName, status];
}

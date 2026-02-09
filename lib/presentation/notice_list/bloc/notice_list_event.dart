part of 'notice_list_bloc.dart';

abstract class NoticeListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotificationListData extends NoticeListEvent {
  final String? slugName;
  LoadNotificationListData({this.slugName});
  @override
  List<Object?> get props => [slugName];
}

class ClearNoticeButton extends NoticeListEvent {}

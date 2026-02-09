part of 'daily_report_bloc.dart';

abstract class DailyReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DailyReportEventLoad extends DailyReportEvent {
  @override
  List<Object> get props => [];
}

class OnSelectReportDateEvent extends DailyReportEvent {
  final String? reportDate;

  OnSelectReportDateEvent({this.reportDate});

  @override
  List<Object> get props => [];
}

class OnSelectStartTimeEvent extends DailyReportEvent {
  final BuildContext context;

  OnSelectStartTimeEvent(this.context);

  @override
  List<Object> get props => [];
}

class OnSelectEndTimeEvent extends DailyReportEvent {
  final BuildContext context;

  OnSelectEndTimeEvent(this.context);

  @override
  List<Object> get props => [];
}

class OnReviewChangedEvent extends DailyReportEvent {
  final int rating;

  OnReviewChangedEvent({required this.rating});

  @override
  List<Object> get props => [rating];
}

class OnDailyReportSubmitEvent extends DailyReportEvent {
  final BuildContext context;
  final int? fileId;

  OnDailyReportSubmitEvent({this.fileId, required this.context});

  @override
  List<Object> get props => [];
}

class OnPendingLeadsEvent extends DailyReportEvent {
  final String? leads;

  OnPendingLeadsEvent({this.leads});

  @override
  List<Object?> get props => [];
}

class OnWorkRecoveryEvent extends DailyReportEvent {
  final String? recovery;

  OnWorkRecoveryEvent({this.recovery});

  @override
  List<Object?> get props => [];
}

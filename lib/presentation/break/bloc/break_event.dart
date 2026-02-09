part of 'break_bloc.dart';

abstract class BreakEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnCustomTimerStart extends BreakEvent {
  final int hour;
  final int min;
  final int sec;

  OnCustomTimerStart({required this.hour, required this.min, required this.sec});

  @override
  List<Object?> get props => [hour, min, sec];
}

class OnBreakBackEvent extends BreakEvent {}

class SelectDatePicker extends BreakEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class GetBreakHistoryData extends BreakEvent {
  final String? date;

  GetBreakHistoryData({
    this.date,
  });

  @override
  List<Object> get props => [];
}

class BreakVerifyQREvent extends BreakEvent {
  final String code;

  BreakVerifyQREvent({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}

class BreakTypeUpdateEvent extends BreakEvent {
  final BreakType type;

  BreakTypeUpdateEvent({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class MealUpdateEvent extends BreakEvent {
  final int takeMeal;

  MealUpdateEvent({
    this.takeMeal = 0,
  });

  @override
  List<Object> get props => [takeMeal];
}

class RemarkEvent extends BreakEvent {
  final StoreRemarksBody body;
  final BuildContext context;

  RemarkEvent({required this.body, required this.context});

  @override
  List<Object> get props => [body];
}

class RemarkUpdateEvent extends BreakEvent {
  final String? remark;

  RemarkUpdateEvent({
    this.remark,
  });

  @override
  List<Object> get props => [];
}

class OnInitialHistoryEvent extends BreakEvent {
  final List<TodayBreakItem>? breaks;

  OnInitialHistoryEvent({this.breaks = const []});

  @override
  List<Object?> get props => [breaks];
}

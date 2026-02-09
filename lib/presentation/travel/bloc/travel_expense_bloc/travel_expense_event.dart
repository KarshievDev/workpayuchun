part of 'travel_expense_bloc.dart';

abstract class TravelExpenseEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class TravelExpenseEventLoad extends TravelExpenseEvent{
  @override
  List<Object> get props => [];
}

class OnTravelModeLoadEvent extends TravelExpenseEvent{
  @override
  List<Object> get props => [];
}

class TravelModeEvent extends TravelExpenseEvent{

  final String mode;

  TravelModeEvent({required this.mode});

  @override
  List<Object> get props => [mode];
}

class TravelCategoryEvent extends TravelExpenseEvent{
  @override
  List<Object> get props => [];
}

class OnSelectDate extends TravelExpenseEvent {
  final String date;

  OnSelectDate({required this.date});

  @override
  List<Object> get props => [date];
}

class OnReviewChanged extends TravelExpenseEvent {
  final int rating;

  OnReviewChanged({required this.rating});

  @override
  List<Object> get props => [rating];
}

class OnExpenseSubmit extends TravelExpenseEvent {
  final BuildContext context;
  final GlobalKey<SfSignaturePadState>? signaturePadKey;
  final List<int> cIds;
  final List<int> fileIds;
  final List<double> amounts;
  final List<String> remarks;
  OnExpenseSubmit({required this.context,this.signaturePadKey,required this.cIds,required this.fileIds,required this.amounts,required this.remarks});

  @override
  List<Object> get props => [context];
}

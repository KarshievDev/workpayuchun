part of 'break_bloc.dart';

abstract class BreakEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBreakInitialData extends BreakEvent {
  GetBreakInitialData();

  @override
  List<Object> get props => [];
}

class SelectDate extends BreakEvent {
  final BuildContext context;
  final bool isSummaryScreen;

  SelectDate(this.context, this.isSummaryScreen);

  @override
  List<Object> get props => [isSummaryScreen];
}

class SelectEmployee extends BreakEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class BreakSummaryDetails extends BreakEvent {
  BreakSummaryDetails();

  @override
  List<Object> get props => [];
}

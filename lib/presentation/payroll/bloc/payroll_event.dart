part of 'payroll_bloc.dart';

abstract class PayrollEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PayrollInitialDataRequest extends PayrollEvent {
  final String? setDate;
  PayrollInitialDataRequest({this.setDate});

  @override
  List<Object?> get props => [setDate];
}

class SelectDatePicker extends PayrollEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}


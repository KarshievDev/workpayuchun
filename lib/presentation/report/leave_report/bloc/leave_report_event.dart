part of 'leave_report_bloc.dart';

abstract class LeaveReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLeaveReportSummary extends LeaveReportEvent {
  GetLeaveReportSummary();

  @override
  List<Object> get props => [];
}

class FilterLeaveReportSummary extends LeaveReportEvent {
  FilterLeaveReportSummary();

  @override
  List<Object> get props => [];
}

class SelectLeaveEmployee extends LeaveReportEvent {
  final PhoneBookUser selectEmployee;

  SelectLeaveEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class LeaveRequest extends LeaveReportEvent {
  LeaveRequest();

  @override
  List<Object> get props => [];
}

class SelectMonthPicker extends LeaveReportEvent {
  final BuildContext context;

  SelectMonthPicker(
    this.context,
  );

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends LeaveReportEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

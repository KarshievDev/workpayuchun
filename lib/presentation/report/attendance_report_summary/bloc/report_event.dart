part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReportData extends ReportEvent {
  GetReportData();

  @override
  List<Object> get props => [];
}

class SelectDate extends ReportEvent {
  final BuildContext context;
  final bool isEmployeeScreen;
  SelectDate(this.context, this.isEmployeeScreen);

  @override
  List<Object> get props => [isEmployeeScreen];
}

class SelectEmployee extends ReportEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class GetAttendanceReportData extends ReportEvent {

  GetAttendanceReportData();

  @override
  List<Object> get props => [];
}


part of 'attendance_report_bloc.dart';

abstract class AttendanceReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MultiAttendanceEvent extends AttendanceReportEvent {
  final String date;
  final BuildContext? context;
  final DailyReport dailyReport;

  MultiAttendanceEvent({required this.date,this.context,required this.dailyReport});

  @override
  List<Object> get props => [date,dailyReport];
}

class GetAttendanceReportData extends AttendanceReportEvent {
  final String? date;

  GetAttendanceReportData({this.date});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends AttendanceReportEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

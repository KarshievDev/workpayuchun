part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaveSummaryApi extends LeaveEvent {
  final int userId;

  LeaveSummaryApi(this.userId);

  @override
  List<Object> get props => [];
}

class LeaveRequest extends LeaveEvent {
  final int userId;

  LeaveRequest(this.userId);

  @override
  List<Object> get props => [userId];
}

class LeaveRequestTypeEvent extends LeaveEvent {
  final int userId;

  LeaveRequestTypeEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class SelectedRequestType extends LeaveEvent {
  final AvailableLeaveType availableLeaveType;

  SelectedRequestType(this.availableLeaveType);

  @override
  List<Object> get props => [availableLeaveType];
}

class SelectedCalendar extends LeaveEvent {
  final String startDate;
  final String endDate;

  SelectedCalendar(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class SelectEmployee extends LeaveEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee( this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class SubmitLeaveRequest extends LeaveEvent {
  final BodyCreateLeaveModel bodyCreateLeaveModel;
  final int uid;
  final BuildContext context;

  SubmitLeaveRequest({required this.bodyCreateLeaveModel,required this.uid,required this.context});

  @override
  List<Object> get props => [bodyCreateLeaveModel,uid];
}

class SelectDatePicker extends LeaveEvent {
  final int userId;
  final BuildContext context;
  SelectDatePicker(this.userId,this.context);

  @override
  List<Object> get props => [userId];
}

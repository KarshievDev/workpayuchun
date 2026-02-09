part of "meeting_bloc.dart";

abstract class MeetingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectedEmployeeEvent extends MeetingEvent {

  final List<PhoneBookUser> phoneBooks;
  SelectedEmployeeEvent(this.phoneBooks);

  @override
  List<Object> get props => [phoneBooks];
}

class MeetingListEvent extends MeetingEvent {
  final String? date;

  MeetingListEvent({this.date});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends MeetingEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

class SelectDatePickerSchedule extends MeetingEvent {
  final BuildContext context;

  SelectDatePickerSchedule(this.context);

  @override
  List<Object> get props => [];
}

class SelectStartTime extends MeetingEvent {
  final BuildContext context;

  SelectStartTime(
    this.context,
  );

  @override
  List<Object> get props => [];
}

class SelectEndTime extends MeetingEvent {
  final BuildContext context;

  SelectEndTime(
    this.context,
  );

  @override
  List<Object> get props => [];
}

class CreateMeetingEvent extends MeetingEvent {
  final MeetingBodyModel bodyCreateMeeting;
  final BuildContext context;
  final String date;

  CreateMeetingEvent(
      {required this.context,
      required this.bodyCreateMeeting,
      required this.date});

  @override
  List<Object> get props => [bodyCreateMeeting, date];
}

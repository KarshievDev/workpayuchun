part of 'conference_bloc.dart';

abstract class ConferenceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class SelectedEmployeeEventConference extends ConferenceEvent {

  final List<PhoneBookUser> phoneBooks;
  SelectedEmployeeEventConference(this.phoneBooks);

  @override
  List<Object> get props => [phoneBooks];
}

class ConferenceInitialDataRequest extends ConferenceEvent {
  ConferenceInitialDataRequest();

  @override
  List<Object?> get props => [];
}
class SelectDatePickerSchedule extends ConferenceEvent {
  final BuildContext context;

  SelectDatePickerSchedule(this.context);

  @override
  List<Object> get props => [];
}

class SelectStartTimeConference extends ConferenceEvent {
  final BuildContext context;

  SelectStartTimeConference(
      this.context,
      );

  @override
  List<Object> get props => [];
}

class SelectEndTimeConference extends ConferenceEvent {
  final BuildContext context;

  SelectEndTimeConference(this.context);

  @override
  List<Object> get props => [];
}
class CreateConferenceEvent extends ConferenceEvent {
  final CreateConferenceBodyModel createConferenceBodyModel;
  final BuildContext context;
  final String date;

  CreateConferenceEvent(
      {required this.context, required this.createConferenceBodyModel, required this.date});

  @override
  List<Object> get props => [createConferenceBodyModel, date];
}


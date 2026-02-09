part of 'appointment_create_bloc.dart';

abstract class AppointmentCreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAppointmentCreateData extends AppointmentCreateEvent {
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? employeeName;
  LoadAppointmentCreateData(
      {this.date, this.startTime, this.endTime, this.employeeName});
  @override
  List<Object> get props => [];
}

class SelectDatePicker extends AppointmentCreateEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class SelectStartTime extends AppointmentCreateEvent {
  final BuildContext context;

  SelectStartTime(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class SelectEmployee extends AppointmentCreateEvent {
  final BuildContext context;
  final PhoneBookUser? selectEmployee;
  SelectEmployee(this.context, this.selectEmployee);
  @override
  List<Object> get props => [
        context,
      ];
}

class SelectEndTime extends AppointmentCreateEvent {
  final BuildContext context;
  SelectEndTime(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class SelectImage extends AppointmentCreateEvent {
  final BuildContext context;
  SelectImage(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class CreateButton extends AppointmentCreateEvent {
  final AppointmentBody appointmentBody;
  final BuildContext context;
  CreateButton(this.context, this.appointmentBody);
  @override
  List<Object> get props => [context, appointmentBody];
}

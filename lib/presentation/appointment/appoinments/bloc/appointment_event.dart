part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAppointmentData extends AppointmentEvent {
  final String? date;

  GetAppointmentData({this.date});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends AppointmentEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

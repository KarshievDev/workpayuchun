part of 'appointment_bloc.dart';

class AppointmentState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final MeetingsListModel? meetingsListData;

  const AppointmentState(
      {this.status, this.currentMonth, this.meetingsListData});

  AppointmentState copy(
      {NetworkStatus? status,
      String? currentMonth,
      MeetingsListModel? meetingsListData}) {
    return AppointmentState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        meetingsListData: meetingsListData ?? this.meetingsListData);
  }

  @override
  List<Object?> get props => [status, currentMonth, meetingsListData];
}

part of 'appointment_create_bloc.dart';

class AppointmentCreateState extends Equatable {
  final NetworkStatus status;

  final String? currentMonth;
  final String? startTime;
  final String? endTime;
  final PhoneBookUser? selectedEmployee;
  final bool? isDateEnable;

  const AppointmentCreateState(
      {this.status = NetworkStatus.initial,
      this.currentMonth,
      this.startTime,
      this.selectedEmployee,
      this.endTime,
      this.isDateEnable});

  AppointmentCreateState copyWith(
      {NetworkStatus? status,
      String? currentMonth,
      final String? startTime,
      final String? endTime,
      final String? employeeName,
      final PhoneBookUser? selectedEmployee,
      final bool? isDateEnable}) {
    return AppointmentCreateState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        selectedEmployee: selectedEmployee ?? this.selectedEmployee,
        isDateEnable: isDateEnable ?? this.isDateEnable);
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        startTime,
        endTime,
        selectedEmployee,
        isDateEnable
      ];
}

part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final NetworkStatus status;
  final PayrollModel? payroll;
  final bool? isLoading;
  final DateTime? dateTime;

  const PayrollState({
    required this.status,
    this.payroll,
    this.isLoading = true,
    this.dateTime,
  });

  PayrollState copyWith(
      {NetworkStatus? status,
      String? year,
      PayrollModel? payroll,
      bool? isLoading,
      DateTime? dateTime}) {
    return PayrollState(
        status: status ?? this.status,
        payroll: payroll ?? this.payroll,
        isLoading: isLoading ?? this.isLoading,
        dateTime: dateTime ?? this.dateTime);
  }

  @override
  List<Object?> get props => [status, payroll, isLoading, dateTime];
}

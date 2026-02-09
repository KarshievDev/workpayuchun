part of 'qr_attendance_bloc.dart';

class QRAttendanceState extends Equatable {
  final NetworkStatus? status;
  final bool? isSuccess;
  final String? onErrorMessage;

  const QRAttendanceState({this.status, this.isSuccess, this.onErrorMessage});

  QRAttendanceState copyWith(
      {NetworkStatus? status,
      String? qrCode,
      BuildContext? context,
      String? onErrorMessage,
      bool? isSuccess}) {
    return QRAttendanceState(
        status: status ?? this.status,
        isSuccess: isSuccess ?? this.isSuccess,
        onErrorMessage: onErrorMessage ?? this.onErrorMessage);
  }

  @override
  List<Object?> get props => [status, isSuccess, onErrorMessage];
}

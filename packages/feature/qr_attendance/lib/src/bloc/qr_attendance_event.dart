part of 'qr_attendance_bloc.dart';

abstract class QRAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QRScanData extends QRAttendanceEvent {
  final String? qrData;
  final BuildContext? context;

  QRScanData({this.qrData, this.context});

  @override
  List<Object?> get props => [qrData];
}

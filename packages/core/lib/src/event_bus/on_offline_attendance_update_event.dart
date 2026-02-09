import 'package:core/src/models/attendance_body.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

class OnOnlineAttendanceUpdateEvent extends AppEvent{

  final AttendanceBody body;

  const OnOnlineAttendanceUpdateEvent({required this.body});

  @override
  List<Object?> get props => [body];

}

class OnOfflineAttendanceUpdateEvent extends AppEvent{

  final AttendanceBody body;

  const OnOfflineAttendanceUpdateEvent({required this.body});

  @override
  List<Object?> get props => [body];

}
part of 'visit_bloc.dart';

abstract class VisitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitCancelEvent extends VisitEvent {
  final BodyVisitCancel? bodyVisitCancel;
  final BuildContext context;

  VisitCancelEvent({this.bodyVisitCancel, required this.context});

  @override
  List<Object?> get props => [bodyVisitCancel];
}

class VisitStatusEvent extends VisitEvent {
  final BodyVisitCancel? bodyVisitCancel;
  final BuildContext context;

  VisitStatusEvent({this.bodyVisitCancel, required this.context});

  @override
  List<Object?> get props => [bodyVisitCancel];
}

class UploadFileEvent extends VisitEvent {
  final File file;
  final BodyImageUpload bodyImageUpload;

  UploadFileEvent({required this.file, required this.bodyImageUpload});

  @override
  List<Object?> get props => [file.path, bodyImageUpload];
}

class VisitUploadPhotoEvent extends VisitEvent {
  final BuildContext context;
  final BodyImageUpload bodyImageUpload;

  VisitUploadPhotoEvent({required this.context,required this.bodyImageUpload});

  @override
  List<Object?> get props => [bodyImageUpload];
}

class CreateRescheduleEvent extends VisitEvent {
  final BodyCreateSchedule? bodyCreateSchedule;
  final BuildContext context;

  CreateRescheduleEvent({this.bodyCreateSchedule, required this.context});

  @override
  List<Object?> get props => [bodyCreateSchedule];
}

class VisitListEvent extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class InitialPositionEvent extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class VisitUpdateEvent extends VisitEvent {
  final BodyUpdateVisit? bodyUpdateVisit;
  final BuildContext context;

  VisitUpdateEvent({this.bodyUpdateVisit, required this.context});

  @override
  List<Object?> get props => [bodyUpdateVisit];
}

class VisitCreateNoteEvent extends VisitEvent {
  final BodyVisitNote? bodyVisitNote;
  final BuildContext context;

  VisitCreateNoteEvent({this.bodyVisitNote, required this.context});

  @override
  List<Object?> get props => [bodyVisitNote];
}

class VisitGoToPositionEvent extends VisitEvent {
  final LatLng latLng;
  final GoogleMapController controller;

  VisitGoToPositionEvent({required this.latLng, required this.controller});

  @override
  List<Object?> get props => [latLng, controller];
}

class VisitDetailsEvent extends VisitEvent {
  final int visitId;
  final double? latitude;
  final double? longitude;

  VisitDetailsEvent({required this.visitId, this.latitude, this.longitude});

  @override
  List<Object?> get props => [visitId, latitude, longitude];
}

class HistoryListEvent extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class SelectDatePickerEvent extends VisitEvent {
  final BuildContext context;

  SelectDatePickerEvent(this.context);

  @override
  List<Object> get props => [];
}

class SelectMonthPickerEvent extends VisitEvent {
  final BuildContext context;

  SelectMonthPickerEvent(this.context);

  @override
  List<Object> get props => [];
}

class CreateVisitEvent extends VisitEvent {
  final BodyCreateVisit bodyCreateVisit;
  final BuildContext context;

  CreateVisitEvent({
    required this.bodyCreateVisit,
    required this.context,
  });

  @override
  List<Object> get props => [bodyCreateVisit];
}

part of 'travel_bloc.dart';

abstract class TravelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TravelPlanEventLoad extends TravelEvent {
  @override
  List<Object> get props => [];
}

class OnSelectFromDate extends TravelEvent {
  final String? fromDate;

  OnSelectFromDate({this.fromDate});

  @override
  List<Object> get props => [];
}

class OnSelectToDate extends TravelEvent {
  final String? toDate;

  OnSelectToDate({this.toDate});

  @override
  List<Object> get props => [];
}

class OnSelectSignedDate extends TravelEvent {
  final String? signedDate;

  OnSelectSignedDate({this.signedDate});

  @override
  List<Object> get props => [];
}

class SubmitButton extends TravelEvent {
  final BuildContext context;
  final GlobalKey<SfSignaturePadState>? signaturePadKey;

  SubmitButton({required this.context, this.signaturePadKey});

  @override
  List<Object> get props => [context];
}

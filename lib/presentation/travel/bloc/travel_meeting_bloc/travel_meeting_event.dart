part of 'travel_meeting_bloc.dart';

abstract class TravelMeetingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TravelMeetingEventLoad extends TravelMeetingEvent {
  @override
  List<Object> get props => [];
}

class OnSelectTravelDate extends TravelMeetingEvent {
  final String? travelDate;

  OnSelectTravelDate({this.travelDate});

  @override
  List<Object> get props => [];
}

class OnSelectScheduleTime extends TravelMeetingEvent {
  final BuildContext context;

  OnSelectScheduleTime(this.context);

  @override
  List<Object> get props => [];
}

class OnSelectStartTime extends TravelMeetingEvent {
  final BuildContext context;

  OnSelectStartTime(this.context);

  @override
  List<Object> get props => [];
}

class OnSelectEndTime extends TravelMeetingEvent {
  final BuildContext context;

  OnSelectEndTime(this.context);

  @override
  List<Object> get props => [];
}

class OnReviewChanged extends TravelMeetingEvent {
  final int rating;

  OnReviewChanged({required this.rating});

  @override
  List<Object> get props => [rating];
}

class SubmitButton extends TravelMeetingEvent {
  final BuildContext context;

  SubmitButton({required this.context});

  @override
  List<Object> get props => [];
}

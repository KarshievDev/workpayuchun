part of 'travel_meeting_bloc.dart';

class TravelMeetingState extends Equatable {
  final NetworkStatus? status;
  final TravelMeetingModel? travelMeetingModel;
  final String? travelDate;
  final String? scheduleTime;
  final String? startTime;
  final String? endTime;
  final int? rating;
  final String? errorMsg;

  const TravelMeetingState(
      {this.status,
      this.travelMeetingModel,
      this.travelDate,
      this.scheduleTime,
      this.errorMsg,
      this.startTime,
      this.endTime,
      this.rating});

  TravelMeetingState copyWith(
      {NetworkStatus? status,
      TravelMeetingModel? travelMeetingModel,
      String? travelDate,
      String? scheduleTime,
      String? startTime,
      String? endTime,
      String? errorMsg,
      int? rating}) {
    return TravelMeetingState(
        status: status ?? this.status,
        travelMeetingModel: travelMeetingModel ?? this.travelMeetingModel,
        travelDate: travelDate ?? this.travelDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        errorMsg: errorMsg ?? this.errorMsg,
        rating: rating ?? this.rating);
  }

  TravelMeetingState reset() => const TravelMeetingState();

  @override
  List<Object?> get props =>
      [status, travelMeetingModel, travelDate, scheduleTime, startTime, endTime, rating, errorMsg];
}

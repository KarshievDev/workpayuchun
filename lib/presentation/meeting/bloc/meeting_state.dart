part of "meeting_bloc.dart";

class MeetingState extends Equatable {
  final NetworkStatus? status;
  final MeetingsListModel? meetingsListResponse;
  final String? currentMonth;
  final String? currentMonthSchedule;
  final String? startTime;
  final String? endTime;
  final List<int> selectedIds;
  final List<String> selectedNames;

  const MeetingState(
      {this.status = NetworkStatus.initial,
      this.meetingsListResponse,
      this.startTime,
      this.endTime,
      this.currentMonth,
      this.currentMonthSchedule,
      this.selectedIds = const [],
      this.selectedNames = const []});

  MeetingState copyWith(
      {NetworkStatus? status,
      String? startTime,
      String? endTime,
      MeetingsListModel? meetingsListResponse,
      String? currentMonth,
      String? currentMonthSchedule,
      List<int>? selectedIds,
      List<String>? selectedNames}) {
    return MeetingState(
        status: status ?? this.status,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        meetingsListResponse: meetingsListResponse ?? this.meetingsListResponse,
        currentMonth: currentMonth ?? this.currentMonth,
        currentMonthSchedule: currentMonthSchedule ?? this.currentMonthSchedule,
        selectedNames: selectedNames ?? this.selectedNames);
  }

  @override
  List<Object?> get props => [
        status,
        meetingsListResponse,
        currentMonth,
        startTime,
        endTime,
        currentMonthSchedule,
        selectedIds,
        selectedNames
      ];
}

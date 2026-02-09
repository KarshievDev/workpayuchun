part of 'conference_bloc.dart';

class ConferenceState extends Equatable {
  final NetworkStatus status;
  final ConferenceModel? conference;
  final String? currentMonthSchedule;
  final String? startTime;
  final String? endTime;
  final List<int> selectedIds;
  final List<String> selectedNames;

  const ConferenceState({
    this.status = NetworkStatus.initial,
    this.conference,
    this.currentMonthSchedule,
    this.startTime,
    this.endTime,
    this.selectedIds = const [],
    this.selectedNames = const []});

  ConferenceState copyWith({NetworkStatus? status,
    ConferenceModel? conference,
    String? currentMonthSchedule,
    String? startTime,
    String? endTime,
    List<int>? selectedIds,
    List<String>? selectedNames}) {
    return ConferenceState(
      status: status ?? this.status,
      conference: conference ?? this.conference,
      currentMonthSchedule: currentMonthSchedule ?? this.currentMonthSchedule,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
        selectedIds: selectedIds ?? this.selectedIds,
        selectedNames: selectedNames ?? this.selectedNames

    );
  }

  @override
  List<Object?> get props => [status, conference,currentMonthSchedule,startTime,endTime,selectedIds,selectedNames];
}

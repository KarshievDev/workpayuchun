part of 'task_bloc.dart';

class TaskState extends Equatable {
  final NetworkStatus status;
  final TaskDashboardModel? taskDashboardData;
  final TaskStatusListResponse? taskStatusListResponse;
  final TaskStatusModel? taskSelectedDropdownValue;
  final TaskDetailsModel? taskDetailsModel;
  final int? taskDetailsRadioValueSelect;
  final double? currentSliderValue;

  const TaskState(
      {required this.status,
      this.taskDashboardData,
      this.taskStatusListResponse,
      this.taskSelectedDropdownValue,
      this.taskDetailsModel,
      this.taskDetailsRadioValueSelect,
      this.currentSliderValue });

  TaskState copyWith(
      {NetworkStatus? status,
      TaskDashboardModel? taskDashboardData,
      TaskStatusListResponse? taskStatusListResponse,
      TaskStatusModel? taskSelectedDropdownValue,
      TaskDetailsModel? taskDetailsModel,
      int? taskDetailsRadioValueSelect,
      double? currentSliderValue}) {
    return TaskState(
        status: status ?? this.status,
        taskDashboardData: taskDashboardData ?? this.taskDashboardData,
        taskStatusListResponse:
            taskStatusListResponse ?? this.taskStatusListResponse,
        taskSelectedDropdownValue:
            taskSelectedDropdownValue ?? this.taskSelectedDropdownValue,
        taskDetailsModel: taskDetailsModel ?? this.taskDetailsModel,
        taskDetailsRadioValueSelect:
            taskDetailsRadioValueSelect ?? this.taskDetailsRadioValueSelect,
        currentSliderValue: currentSliderValue ?? this.currentSliderValue);
  }

  @override
  List<Object?> get props => [
        status,
        taskDashboardData,
        taskStatusListResponse,
        taskSelectedDropdownValue,
        taskDetailsModel,
        taskDetailsRadioValueSelect,
        currentSliderValue,
      ];
}

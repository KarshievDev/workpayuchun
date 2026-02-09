part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitialDataRequest extends TaskEvent {
  TaskInitialDataRequest();

  @override
  List<Object?> get props => [];
}

class TaskListOfDataRequest extends TaskEvent {
  TaskListOfDataRequest();

  @override
  List<Object?> get props => [];
}

class TaskSetDropdownValue extends TaskEvent {
  final TaskStatusModel taskStatusSetValue;

  TaskSetDropdownValue({required this.taskStatusSetValue});

  @override
  List<Object?> get props => [taskStatusSetValue];
}

class TaskDetailsStatusRadioValueSet extends TaskEvent {
  final int statusId;

  TaskDetailsStatusRadioValueSet({required this.statusId});

  @override
  List<Object?> get props => [statusId];
}

class TaskDetailsSliderValueSet extends TaskEvent {
  final double sliderValue;

  TaskDetailsSliderValueSet({required this.sliderValue});

  @override
  List<Object?> get props => [sliderValue];
}

class TaskDetailsStatusUpdateRequest extends TaskEvent {
  final String id;
  final String priority;
  final BuildContext? context;
  final TaskBloc bloc;

  TaskDetailsStatusUpdateRequest(
      {required this.id, required this.priority, required this.context, required this.bloc});

  @override
  List<Object?> get props => [id, priority, context, bloc];
}

import 'package:easy_localization/easy_localization.dart';

class TaskStatusModel {
  int? id;
  String? title;

  TaskStatusModel({this.id, this.title});
}

List<TaskStatusModel> statusList = [
  TaskStatusModel(id: 24, title: 'not_started'.tr()),
  TaskStatusModel(id: 25, title: 'on_hold'.tr()),
  TaskStatusModel(id: 26, title: 'in_progress'),
  TaskStatusModel(id: 27, title: 'Completed'),
  TaskStatusModel(id: 28, title: 'cancelled'),
];

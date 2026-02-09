import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/task/model/status_model.dart';

import '../../task.dart';

class TaskStatusDropdown extends StatelessWidget {
  const TaskStatusDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 150.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TaskStatusModel>(
              isExpanded: true,
              hint: Text(
                "in_progress".tr(),
                style: const TextStyle(fontSize: 14),
              ),
              value: state.taskSelectedDropdownValue,
              icon: const Icon(
                Icons.arrow_downward,
                size: 20,
              ),
              iconSize: 24,
              elevation: 16,
              onChanged: (TaskStatusModel? newValue) {
                context
                    .read<TaskBloc>()
                    .add(TaskSetDropdownValue(taskStatusSetValue: newValue!));
              },
              items: statusList.map<DropdownMenuItem<TaskStatusModel>>(
                  (TaskStatusModel value) {
                return DropdownMenuItem<TaskStatusModel>(
                  value: value,
                  child: Text(
                    value.title ?? ''.tr(),
                    style: TextStyle(fontSize: 14.r),
                  ).tr(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

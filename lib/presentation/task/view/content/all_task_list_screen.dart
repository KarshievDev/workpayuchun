import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

import '../../task.dart';

class AllTaskListScreen extends StatelessWidget {
  const AllTaskListScreen({super.key, this.taskCollection});

  final List<TaskCollection>? taskCollection;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All ${bloc.state.taskSelectedDropdownValue?.title ?? ''} Task',
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: taskCollection?.isNotEmpty == true
          ? ListView.builder(
              itemCount: taskCollection?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final data = taskCollection?[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TaskListCard(
                    onTap: () {
                      NavUtil.navigateScreen(
                        context,
                        TaskScreenDetails(
                          bloc: bloc,
                          taskId: data!.id.toString(),
                        ),
                      );
                    },
                    userCount: data?.usersCount,
                    taskListData: data,
                    taskName: data?.title,
                    tapButtonColor: const Color(0xFF00a8e6),
                    taskStartDate: data?.dateRange,
                  ),
                );
              },
            )
          : const Center(
              child: NoDataFoundWidget(),
            ),
    );
  }
}

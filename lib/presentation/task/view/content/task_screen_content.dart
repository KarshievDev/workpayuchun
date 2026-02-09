import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/task/task.dart';
import 'package:strawberryhrm/presentation/task/view/content/title_with_see_all_content.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/shimmers.dart';

class TaskScreenContent extends StatelessWidget {
  const TaskScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final staticsData = state.taskDashboardData?.data?.statistics;
        final tasks = state.taskDashboardData?.data?.tasks ?? [];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TaskDashboardCardList(staticsData: staticsData),
                TitleWithSeeAll(
                  context: context,
                  onTap: () {
                    NavUtil.navigateScreen(
                        context,
                        BlocProvider.value(
                            value: context.read<TaskBloc>(), child: AllTaskListScreen(taskCollection: tasks)));
                  },
                  title: '',
                  child: const TaskStatusDropdown(),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                state.taskDashboardData != null
                    ? tasks.isNotEmpty == true
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = tasks[index];
                              return TaskListCard(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                    context,
                                    TaskScreenDetails(
                                      bloc: context.read<TaskBloc>(),
                                      taskId: data.id.toString(),
                                    ),
                                  );
                                },
                                userCount: data.usersCount,
                                taskListData: data,
                                taskName: data.title,
                                tapButtonColor: const Color(0xFF00a8e6),
                                taskStartDate: data.dateRange,
                              );
                            },
                          )
                        : const NoDataFoundWidget()
                    : ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return const TileShimmer(
                            isSubTitle: true,
                          );
                        },
                      ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'content.dart';

class TaskDashboardCardList extends StatelessWidget {
  const TaskDashboardCardList({
    super.key,
    required this.staticsData,
  });

  final List<Statistics>? staticsData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TaskDashboardCard(
              customPainter: TotalTaskCustomPainter(),
              title: staticsData?[0].text,
              count: staticsData?[0].count.toString(),
              titleAsset: "assets/task/task.png",
              titleColor: const Color(0xffD8808F),
            ),
            const SizedBox(
              width: 13,
            ),
            TaskDashboardCard(
              customPainter: TotalCompleteTaskCustomPainter(),
              title: staticsData?[1].text,
              count: staticsData?[1].count.toString(),
              titleAsset: "assets/task/complete_task.png",
              titleColor: const Color(0xff80C090),
            ),
          ],
        ),
        Row(
          children: [
            TaskDashboardCard(
              customPainter: TotalTaskInProgressCustomPainter(),
              title: staticsData?[2].text,
              count: staticsData?[2].count.toString(),
              titleAsset: "assets/task/task_in_progress.png",
              titleColor: const Color(0xffD3B980),
            ),
            const SizedBox(
              width: 13,
            ),
            TaskDashboardCard(
              customPainter: TotalTaskInReviewCustomPainter(),
              title: staticsData?[3].text,
              count: staticsData?[3].count.toString(),
              titleAsset: "assets/task/task_in_review.png",
              titleColor: const Color(0xff80BBC3),
            ),
          ],
        ),
      ],
    );
  }
}

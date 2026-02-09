import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/task/task.dart';

class TaskScreenDetails extends StatelessWidget {
  const TaskScreenDetails({super.key, this.bloc, required this.taskId});
  final TaskBloc? bloc;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("task_details").tr(),
      ),
      body: FutureBuilder(
        future: bloc?.onTaskDetailsDataRequest(taskId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.data?.taskDetails;
            final members = snapshot.data?.data?.members;

            if (data != null) {
              bloc?.add(
                  TaskDetailsStatusRadioValueSet(statusId: data.statusId!));

              bloc?.add(TaskDetailsSliderValueSet(
                  sliderValue: double.parse(data.progress.toString())));

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitleAndValue(
                          title: 'task_name'.tr(), data: data.title ?? ''),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "description".tr(),
                        style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0.r),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        data.description ?? "",
                        maxLines: 5,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: const Color(0xff8A8A8A), fontSize: 14.0.r),
                      ),
                      buildTitleAndValue(
                          title: "priority".tr(), data: data.priority),
                      buildTitleAndValue(
                        title: "task_supervisor".tr(),
                        data: data.supervisor ?? "",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "deadline".tr(),
                            style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0.r),
                          ),
                          data.status != "Completed"
                              ? InkWell(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (_) => buildAlertDialog(
                                          data, bloc!, context),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5).r,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          // color: AppColors.colorPrimary,
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "update_status".tr(),
                                      style:  TextStyle(
                                          color: Colors.black, fontSize: 12.0.r),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                     Text(
                                      "task_complete".tr(),
                                      style:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0.r,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Image.asset(
                                      "assets/task/check.png",
                                      height: 18.0.r,
                                      width: 18.0.r,
                                    )
                                  ],
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/task/light_calender.png",
                            height: 44.0,
                            width: 44.0,
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Text(
                            data.startDate ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0.r),
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Image.asset(
                            "assets/task/light_calender.png",
                            height: 44.0,
                            width: 44.0,
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Text(
                            data.endDate ?? "",
                            style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0.r),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ProgressIndicatorWithPercentage(
                        percentageActiveColor: Colors.blue,
                        percentageDisableColor: const Color(0xffC9C9C9),
                        activeContainerWidth: ((screenWidth - 80.0) *
                                double.parse('${data.progress ?? 0}')) /
                            100,
                        deActivateContainerWidth: (screenWidth - 80.0) -
                            ((screenWidth - 85.0) *
                                    double.parse('${data.progress ?? 0}')) /
                                100,
                        containerHeight: 12.0,
                        percentage: "${data.progress ?? 0}%",
                        percentageTextHeight: 16.0,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "assignee".tr(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: const Color(0xff8A8A8A), fontSize: 14.0.r),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: members?.isNotEmpty == true
                            ? members!
                                .map((e) => Stack(
                                      children: [
                                        Positioned(
                                            child: InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AssignAlertDialog(
                                                assignMembers: e,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 36.0.r,
                                            width: 36.0.r,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(e.avatar!),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.circle),
                                          ),
                                        ))
                                      ],
                                    ))
                                .toList()
                            : [],
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  AlertDialog buildAlertDialog(
      TaskDetails? data, TaskBloc bloc, BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text("${data?.title} ", style: TextStyle(fontSize: 16.r)),
      content: StatefulBuilder(
        builder: (context, void Function(void Function()) setState) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.35.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("your_task_status", style: TextStyle(fontSize: 14.r),).tr(),
                RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text("not_started", style: TextStyle(fontSize: 14.r)).tr(),
                  value: 24,
                  groupValue: bloc.state.taskDetailsRadioValueSelect,
                  onChanged: (int? value) {
                    setState(() {
                      bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                    });
                  },
                ),
                RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title:  Text("on_hold", style: TextStyle(fontSize: 14.r)).tr(),
                  value: 25,
                  groupValue: bloc.state.taskDetailsRadioValueSelect,
                  onChanged: (int? value) {
                    setState(() {
                      bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                    });
                  },
                ),
                RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title:  Text("in_progress", style: TextStyle(fontSize: 14.r)).tr(),
                  value: 26,
                  groupValue: bloc.state.taskDetailsRadioValueSelect,
                  onChanged: (int? value) {
                    setState(() {
                      bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                    });
                  },
                ),
                RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title:  Text("completed", style: TextStyle(fontSize: 14.r)).tr(),
                  value: 27,
                  groupValue: bloc.state.taskDetailsRadioValueSelect,
                  onChanged: (int? value) {
                    setState(() {
                      bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                    });
                  },
                ),
                Slider(
                  value: bloc.state.currentSliderValue ?? 0.0,
                  max: 100,
                  divisions: 5,
                  label: bloc.state.currentSliderValue?.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      bloc.add(TaskDetailsSliderValueSet(sliderValue: value));
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              bloc.add(TaskDetailsStatusUpdateRequest(
                  id: data!.id.toString(),
                  priority: data.priorityId.toString(),
                  context: context,
                  bloc: bloc));

              Navigator.pop(context);
            },
            child: Text(
              'okay'.tr(),
              style:  TextStyle(color: Colors.white, fontSize: 12.r),
            ),
          ),
        ),
      ],
    );
  }

  ListTile buildTitleAndValue({String? title, String? data}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Text(
        '$title :',
        style:  TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12.0.r),
      ),
      title: Text(data ?? "", style: TextStyle(fontSize: 14.r),),
    );
  }
}

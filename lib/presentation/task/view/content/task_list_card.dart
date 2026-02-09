import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

import 'content.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard(
      {super.key,
      this.tapButtonColor,
      this.taskEndDate,
      this.taskName,
      this.userCount,
      required this.onTap,
      this.taskStartDate,
      this.taskListData});

  final String? taskName, taskStartDate, taskEndDate;
  final int? userCount;
  final Color? tapButtonColor;
  final Function()? onTap;
  final TaskCollection? taskListData;

  @override
  Widget build(BuildContext context) {
    List<Widget> assigns = [];

    if (taskListData?.members != null) {
      final data = taskListData?.members;
      for (int i = 0; i < data!.length; i++) {
        assigns.add(Positioned(
          left: i * 15,
          top: 0.0,
          bottom: 0.0,
          child: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: data.elementAt(i).name != null
                      ? Text("name: ${data.elementAt(i).name} ").tr()
                      : const SizedBox(),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.elementAt(i).designation != null
                              ? Text("designation: ${data.elementAt(i).designation ?? ""}")
                                  .tr()
                              : const SizedBox(),
                          data.elementAt(i).department != null
                              ? Text("department: ${data.elementAt(i).department ?? ""}")
                                  .tr()
                              : const SizedBox(),
                          data.elementAt(i).phone != null
                              ? Text("phone: ${data.elementAt(i).phone ?? ""}")
                                  .tr()
                              : const SizedBox(),
                          data.elementAt(i).email != null
                              ? Text("email: ${data.elementAt(i).email ?? ""}")
                                  .tr()
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: 30.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${data.elementAt(i).avatar}'))),
              child: const SizedBox.shrink(),
            ),
          ),
        ));
      }
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      taskName ?? "".tr(),
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0.r),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "assignee".tr(),
                style:  TextStyle(
                    color: const Color(0xff8A8A8A),
                    fontSize: 12.0.r,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0.r * assigns.length,
                    height: 40.0.r,
                    child: Stack(children: assigns),
                  ),
                  userCount == 0
                      ? const SizedBox()
                      : Text(
                          '${userCount ?? 0}+',
                          textAlign: TextAlign.justify,
                          style:  TextStyle(
                              color: const Color(0xff8A8A8A),
                              fontSize: 14.0.r,
                              fontWeight: FontWeight.w400),
                        ),
                  const Spacer(),
                  TaskListButtonWithDate(
                    buttonColor: tapButtonColor,
                    firstDate: taskStartDate ?? "",
                    endData: taskEndDate ?? "",
                    verticalPadding: 6,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

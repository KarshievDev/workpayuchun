import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AssignAlertDialog extends StatelessWidget {
  const AssignAlertDialog({
    required this.assignMembers,
    super.key,
  });

  final TaskDetailsMember assignMembers;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: assignMembers.name != null
          ? Text("name: ${assignMembers.name} ").tr()
          : const SizedBox(),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              assignMembers.designation != null
                  ? Text("designation: ${assignMembers.designation ?? ""}").tr()
                  : const SizedBox(),
              assignMembers.department != null
                  ? Text("department: ${assignMembers.department ?? ""}").tr()
                  : const SizedBox(),
              assignMembers.phone != null
                  ? Text("phone: ${assignMembers.phone ?? ""}").tr()
                  : const SizedBox(),
              assignMembers.email != null
                  ? Text("email: ${assignMembers.email ?? ""}").tr()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('ok'),
        ),
      ],
    );
  }
}

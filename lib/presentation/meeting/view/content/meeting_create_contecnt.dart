import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/meeting/bloc/meeting_bloc.dart';
import 'package:strawberryhrm/presentation/meeting/view/content/attachment_content.dart';
import 'package:strawberryhrm/presentation/meeting/view/content/meeting_time_cart.dart';
import 'package:strawberryhrm/presentation/multi_selection_employee/multi_selection_employee_page.dart';
import 'package:core/core.dart';
import '../../../../res/common_text_widget.dart';
import 'meeting_name_list.dart';

class MeetingCreateContent extends StatelessWidget {
  final MeetingBodyModel meetingBodyModel;

  const MeetingCreateContent({super.key, required this.meetingBodyModel});

  @override
  Widget build(BuildContext context) {

    final meetingBloc = context.read<MeetingBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFiledWithTitle(
          title: "title".tr(),
          labelText: 'enter_title'.tr(),
          onChanged: (data) {
            meetingBodyModel.title = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CommonTextFiledWithTitle(
          title: "description".tr(),
          labelText: "enter_text".tr(),
          onChanged: (data) {
            meetingBodyModel.description = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CommonTextFiledWithTitle(
          title: "location".tr(),
          labelText: 'enter_location'.tr(),
          onChanged: (data) {
            meetingBodyModel.location = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "date_schedule".tr(),
            style: TextStyle(fontSize: 14.r, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          color: colorCardBackground,
          elevation: 0.0,
          child: InkWell(
            onTap: () {
              meetingBloc.add(SelectDatePickerSchedule(context));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meetingBloc.state.currentMonthSchedule ?? 'select_date'.tr(),
                    style: TextStyle(fontSize: 12.r),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.grey,
                    size: 18.r,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        MeetingTimeCart(meetingState: meetingBloc.state),
        const SizedBox(height: 26),
        Text(
          tr("Add Member"),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: colorCardBackground,
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).r,
            onTap: () async {
              if (meetingBloc.state.selectedNames.isNotEmpty == true) {
                meetingBloc.state.selectedNames.clear();
                meetingBloc.state.selectedIds.clear();
              }

              /// Get Selected Employee List
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiSelectionEmployee(
                      onItemSelected: (items) {
                        meetingBodyModel.participants = items.map((e) => '${e.id}').toList().join(',');
                        meetingBloc.add(SelectedEmployeeEvent(items));
                      },
                    ),
                  ));
            },
            title: Text(
              tr("add_meeting_member"),
              style: TextStyle(fontSize: 12.r),
            ),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
            ),
            trailing: const Icon(Icons.add),
          ),
        ),
        MeetingNameList(state: meetingBloc.state),
        const SizedBox(
          height: 26,
        ),
        AttachmentContent(meetingBodyModel: meetingBodyModel),
        const SizedBox(
          height: 26,
        ),
      ],
    );
  }
}

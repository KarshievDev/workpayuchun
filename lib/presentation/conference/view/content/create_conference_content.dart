import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/conference/bloc/conference_bloc.dart';
import 'package:strawberryhrm/presentation/conference/view/content/conference_name_list.dart';
import 'package:strawberryhrm/presentation/conference/view/content/conference_time_card.dart';
import 'package:strawberryhrm/res/common_text_widget.dart';
import 'package:core/core.dart';
import '../../../multi_selection_employee/multi_selection_employee_page.dart';

class CreateConferenceContent extends StatelessWidget {
  final ConferenceState? state;
  final CreateConferenceBodyModel? createConferenceBodyModel;
  const CreateConferenceContent({super.key,this.createConferenceBodyModel,this.state});

  @override
  Widget build(BuildContext context) {
    final conferenceBloc = context.read<ConferenceBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFiledWithTitle(
          title: "title".tr(),
          labelText: 'enter_title'.tr(),
          onChanged: (data){
            createConferenceBodyModel?.title = data;
          },
        ),
        const SizedBox(height: 25,),
        CommonTextFiledWithTitle(
          title: "description".tr(),
          labelText: "enter_text".tr(),
          onChanged: (data) {
            createConferenceBodyModel?.description = data;
          },
        ),
        const SizedBox(height: 25),
        Padding(padding: const EdgeInsets.only(bottom: 16.0),
          child: Text("date_schedule".tr(), style: TextStyle(fontSize: 14.r, color: Colors.black, fontWeight: FontWeight.bold),),
        ),
        Card(
          color: colorCardBackground, elevation: 0.0,
          child: InkWell(
            onTap: () {
              conferenceBloc.add(SelectDatePickerSchedule(context));
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.currentMonthSchedule ?? 'select_date'.tr(), style: TextStyle(fontSize: 12.r),),
                  Icon(Icons.arrow_drop_down_sharp, color: Colors.grey, size: 18.r)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ConferenceTimeCart(conferenceState: state,),
        const SizedBox(height: 26),
        Text(tr("Add Member"),
          style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
        ),
        const SizedBox(height: 10,),
        Card(
          color: colorCardBackground,
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).r,
            onTap: () async {
              if (state?.selectedNames.isNotEmpty == true) {
                state?.selectedNames.clear();
                state?.selectedIds.clear();
              }
              /// Get Selected Employee List
              Navigator.push(context, MaterialPageRoute(builder: (context) => MultiSelectionEmployee(
                      onItemSelected: (items) {
                        conferenceBloc.add(SelectedEmployeeEventConference(items));
                      },
                    ),
                  ));
            },
            title: Text(tr("add_meeting_member"),  style: TextStyle(fontSize: 12.r),),
            leading: const CircleAvatar(backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),),
            trailing: const Icon(Icons.add),
          ),
        ),
        ConferenceNameList(state: state),
        const SizedBox(height: 26),
      ],
    );
  }
}

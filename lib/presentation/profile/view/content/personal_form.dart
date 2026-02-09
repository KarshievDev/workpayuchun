import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/update/update_profile_bloc.dart';
import 'package:strawberryhrm/presentation/profile/model/update_official_data.dart';
import 'package:strawberryhrm/presentation/profile/view/content/profile_dropdown.dart';
import 'package:strawberryhrm/res/widgets/custom_button_widget1.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';

import 'custom_text_field_with_title.dart';
import 'gender_content.dart';

class PersonalForm extends StatefulWidget {
  final Profile? profile;
  final Bloc bloc;
  final Settings? settings;
  final Function(BodyPersonalInfo) onPersonalUpdate;

  const PersonalForm({
    super.key,
    required this.profile,
    required this.bloc,
    required this.onPersonalUpdate,
    required this.settings,
  });

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  BodyPersonalInfo personal = BodyPersonalInfo();

  @override
  void initState() {
    personal.gender = widget.profile?.personal?.gender?.toLowerCase() ?? 'male';
    personal.phone = widget.profile?.personal?.phone;
    personal.birthDate = getDDMMYYYYAsString(
      date: widget.profile?.personal?.birthDate ?? '',
    );
    personal.address = widget.profile?.personal?.address;
    personal.nationality = widget.profile?.personal?.nationality;
    personal.nidCardNumber = widget.profile?.personal?.nid;
    personal.nidFile = null;
    personal.passportNumber = widget.profile?.personal?.passport;
    personal.passportFile = null;
    personal.bloodGroup = widget.profile?.personal?.bloodGroup ?? 'O+';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenderRadioContent(
          personal: personal,
          bloc: widget.bloc,
          onPersonalUpdate: (personalData) {
            personal.gender = personalData.gender;
            widget.onPersonalUpdate(personalData);
          },
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          title: 'phone'.tr(),
          value: '${widget.profile?.personal?.phone}',
          onData: (data) {
            personal.phone = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(height: 16.0),
        Text(
          'date_of_birth'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomDatePicker(
          label: getDateddMMMyyyyString(dateTime: widget.bloc.state.dateTime),
          onDatePicked: (DateTime date) {
            personal.birthDate = getDateAsString(
              dateTime: date,
              format: 'yyyy-MM-dd',
            );
            widget.onPersonalUpdate(personal);
            widget.bloc.add(OnJoiningDateUpdate(date: date));
          },
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          title: 'address'.tr(),
          value: widget.profile?.personal?.address ?? '',
          onData: (data) {
            personal.address = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          title: 'nationality'.tr(),
          value: widget.profile?.personal?.nationality ?? '',
          onData: (data) {
            personal.nationality = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          title: 'nid'.tr(),
          value: widget.profile?.personal?.nid ?? '',
          onData: (data) {
            personal.nidCardNumber = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          title: 'passport_number'.tr(),
          value: widget.profile?.personal?.nid ?? '',
          onData: (data) {
            personal.passportNumber = data;
            widget.onPersonalUpdate(personal);
          },
        ),
        const SizedBox(height: 16.0),
        BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            return SimpleDropDown(
              items: bloodGroup,
              title: 'blood'.tr(),
              onChanged: (bloodGroup) {
                personal.bloodGroup = bloodGroup;
                widget.onPersonalUpdate(personal);
                widget.bloc.add(OnBloodUpdate(bloodGroup: bloodGroup!));
              },
              initialData: widget.bloc.state.bloodGroup ?? personal.bloodGroup,
            );
          },
        ),
        const SizedBox(height: 16.0),
        CustomButton1(
          onTap: () {
            widget.bloc.add(
              ProfileUpdate(slug: 'personal', data: personal.toJson()),
            );
          },
          text: 'save'.tr(),
          radius: 8.0,
          asyncCall: widget.bloc.state.status == NetworkStatus.loading,
          textSize: 14.r,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

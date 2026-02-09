import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/update_official_data.dart';
import 'custom_text_field_with_title.dart';

class EmergencyForm extends StatefulWidget {
  final Profile? profile;
  final Bloc bloc;
  final Settings? settings;
  final Function(BodyEmergencyInfo) onEmergencyUpdate;

  const EmergencyForm(
      {super.key,
      required this.profile,
      required this.bloc,
      required this.onEmergencyUpdate,
      required this.settings});

  @override
  State<EmergencyForm> createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  BodyEmergencyInfo emergency = BodyEmergencyInfo();

  @override
  void initState() {
    emergency.name = widget.profile?.emergency?.name;
    emergency.mobile = widget.profile?.emergency?.mobile;
    emergency.relationship = widget.profile?.emergency?.relationship;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'name'.tr(),
          value: widget.profile?.emergency?.name,
          hints: widget.profile?.emergency?.name,
          onData: (data) {
            emergency.name = data;
            widget.onEmergencyUpdate(emergency);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'mobile'.tr(),
          value: widget.profile?.emergency?.mobile,
          hints: widget.profile?.emergency?.mobile,
          onData: (data) {
            emergency.mobile = data;
            widget.onEmergencyUpdate(emergency);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'relationship'.tr(),
          value: widget.profile?.emergency?.relationship,
          hints: widget.profile?.emergency?.relationship,
          onData: (data) {
            emergency.relationship = data;
            widget.onEmergencyUpdate(emergency);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomButton1(
          onTap: () {
            widget.bloc.add(
                ProfileUpdate(slug: 'emergency', data: emergency.toJson()));
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

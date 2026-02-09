import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/personal_form.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/update_official_data.dart';
import 'emergency_form.dart';
import 'financial_form.dart';
import 'official_form.dart';

class EditProfileContent extends StatefulWidget {
  final String? pageName;
  final Settings? settings;
  final Profile? profile;
  final Bloc bloc;

  const EditProfileContent(
      {super.key,
      required this.pageName,
      required this.settings,
      required this.profile,
      required this.bloc});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  BodyOfficialInfo official = BodyOfficialInfo();
  BodyPersonalInfo personal = BodyPersonalInfo();
  BodyFinancialInfo financial = BodyFinancialInfo();
  BodyEmergencyInfo emergency = BodyEmergencyInfo();

  @override
  Widget build(BuildContext context) {
    UpdateProfileBloc bloc = context.watch<UpdateProfileBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.pageName == 'official')
              OfficialForm(
                profile: widget.profile,
                bloc: bloc,
                onOfficialUpdate: (data) {
                  official = data;
                },
                settings: widget.settings,
              ),
            if (widget.pageName == 'personal')
              PersonalForm(
                profile: widget.profile,
                bloc: bloc,
                onPersonalUpdate: (data) {
                  personal = data;
                },
                settings: widget.settings,
              ),
            if (widget.pageName == 'financial')
              FinancialForm(
                profile: widget.profile,
                bloc: bloc,
                onFinancialUpdate: (data) {
                  financial = data;
                },
                settings: widget.settings,
              ),
            if (widget.pageName == 'emergency')
              EmergencyForm(
                profile: widget.profile,
                bloc: bloc,
                onEmergencyUpdate: (data) {
                  emergency = data;
                },
                settings: widget.settings,
              ),
          ],
        ),
      ),
    );
  }
}

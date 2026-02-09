import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/presentation/profile/bloc/update/update_profile_bloc.dart';
import 'edit_profile_content.dart';

class EditOfficialInfo extends StatelessWidget {
  final String? pageName;
  final Settings? settings;
  final Profile? profile;
  final Bloc profileBloc;

  const EditOfficialInfo(
      {super.key,
      required this.pageName,
      required this.settings,
      required this.profile,
      required this.profileBloc});

  static Route route(
          {required String pageName,
          required Settings? settings,
          required Profile? profile,
          required ProfileBloc bloc}) =>
      MaterialPageRoute(
          builder: (context) => EditOfficialInfo(
                pageName: pageName,
                settings: settings,
                profile: profile,
                profileBloc: bloc,
              ));

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => UpdateProfileBloc(
          metaClubApiClient: MetaClubApiClient(
              httpService: instance())),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Update $pageName data'.tr(),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            if (state.status == NetworkStatus.success) {
              profileBloc.add(ProfileLoadRequest());
              Navigator.of(context).pop();
            }
            if (state.status == NetworkStatus.failure) {}
            if (state.status == NetworkStatus.loading) {}
          },
          child: EditProfileContent(
            pageName: pageName,
            settings: settings,
            profile: profile,
            bloc: profileBloc,
          ),
        ),
      ),
    );
  }
}

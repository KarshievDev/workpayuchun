import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/emergency_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/content/finalcial_profile_content.dart';
import 'package:strawberryhrm/presentation/profile/view/content/personal_profile_content.dart';
import '../../../upload_file/view/upload_content.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'official_profile_content.dart';

class ProfileContent extends StatelessWidget {
  final Settings? settings;
  final TabController controller;

  const ProfileContent({super.key, required this.settings,required this.controller});

  @override
  Widget build(BuildContext context) {



    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NetworkStatus.success) {
            if (state.profile != null) {
              return Column(
                children: [
                  const SizedBox(height: 16.0),
                  Center(
                    child: UploadContent(
                      onFileUploaded: (FileUpload? data) {
                        context.read<ProfileBloc>().add(ProfileAvatarUpdate(avatarId: data?.fileId));
                      },
                      initialAvatar: state.profile?.personal?.avatar,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        state.profile?.official != null
                            ? OfficialProfileContent(profile: state.profile!, settings: settings)
                            : const SizedBox.shrink(),
                        state.profile?.personal != null
                            ? PersonalProfileContent(profile: state.profile!, settings: settings)
                            : const SizedBox.shrink(),
                        state.profile?.financial != null
                            ? FinancialProfileContent(profile: state.profile!, settings: settings)
                            : const SizedBox.shrink(),
                        state.profile?.emergency != null
                            ? EmergencyProfileContent(profile: state.profile!, settings: settings)
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          if (state.status == NetworkStatus.failure) {
            return Center(child: Text('failed_to_load_profile'.tr()));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

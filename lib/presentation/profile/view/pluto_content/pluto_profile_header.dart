import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_content.dart';

class PlutoProfileHeader extends StatelessWidget {
  final ProfileState? state;
  const PlutoProfileHeader({super.key,this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Center(
          child: UploadContent(onFileUploaded: (FileUpload? data) {
            context.read<ProfileBloc>().add(ProfileAvatarUpdate(avatarId: data?.fileId));},
            initialAvatar: state?.profile?.personal?.avatar,),),
        const SizedBox(height: 12,),
        Text(state?.profile?.personal?.name ?? "No Name Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Branding.colors.textSecondary),),
        Text(state?.profile?.official?.email ?? "No Email address Found",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Branding.colors.textSecondary.withValues(alpha: 0.6))),
        const SizedBox(height: 12,),
      ],
    );
  }
}

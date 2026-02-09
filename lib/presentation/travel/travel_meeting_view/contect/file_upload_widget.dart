import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_meeting_bloc/travel_meeting_bloc.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        UploadDocContent(
          buttonText: "File Upload",
          onFileUpload: (FileUpload? data) {
            context.read<TravelMeetingBloc>().fileId = data?.fileId;
          },
          initialAvatar:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
        ),
      ],
    );
  }
}

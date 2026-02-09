import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';

class ExpenseAttachmentContent extends StatelessWidget {
  const ExpenseAttachmentContent({
    super.key,
    required this.expenseCreateBody,
  });

  final ExpenseCreateBody expenseCreateBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr("attachment"),
          style:
               TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
        ),
        const SizedBox(
          height: 16,
        ),
        UploadDocContent(
          onFileUpload: (FileUpload? data) {
            if (kDebugMode) {
              print(data?.previewUrl);
            }
            expenseCreateBody.attachment = data?.fileId;
          },
          initialAvatar:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
        ),
      ],
    );
  }
}

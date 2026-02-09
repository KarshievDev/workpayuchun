import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';

class TravelExpenseInfoCard extends StatelessWidget {
  final TravelCategory category;
  final int index;
  final Function(String?) onAmount;
  final Function(String?) onRemark;
  final Function(FileUpload?) onUploadFile;

  const TravelExpenseInfoCard(
      {super.key,
      required this.category,
      required this.index,
      required this.onAmount,
      required this.onRemark,
      required this.onUploadFile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              title: "${category.name} Amount",
              value: '',
              textInputType: TextInputType.number,
              hints: "enter_the_amount_that_you_have_spent".tr(),
              onData: onAmount,
            ),
            const SizedBox(
              height: 8.0,
            ),
            UploadDocContent(
              buttonText: "File Upload",
              onFileUpload: onUploadFile,
              initialAvatar:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomTextField(
              title: "Remark * ",
              value: '',
              sizedBoxHeight: 8.0,
              hints: "remark".tr(),
              onData: onRemark,
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

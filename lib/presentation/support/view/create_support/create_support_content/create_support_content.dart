import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/support/content/priority_id_widget.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';
import '../../../../../res/widgets/custom_button.dart';
import '../../../bloc/bloc.dart';

class CreateSupportListContent extends StatelessWidget {
  const CreateSupportListContent({super.key});

  @override
  Widget build(BuildContext context) {
    BodyCreateSupport createSupport = BodyCreateSupport();

    return BlocBuilder<SupportBloc, SupportState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("priority"),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.r,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),

                /// priority_id => [14 = high , 15 = medium , 16 = low' ]
                PriorityIdWidget(createSupport: createSupport),
                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                  title: 'Subject'.tr(),
                  hints: "write_subject".tr(),
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    createSupport.subject = data;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                CustomTextField(
                  title: tr("what_support_do_you_need?"),
                  hints: "write_description".tr(),
                  maxLine: 5,
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    createSupport.description = data;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                UploadDocContent(
                  onFileUpload: (FileUpload? data) {
                    if (kDebugMode) {
                      print(data?.fileId);
                    }
                    createSupport.previewId = data?.previewUrl;
                  },
                  initialAvatar:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                ),

                const SizedBox(
                  height: 20,
                ),

                CustomHButton(
                  title: tr("submit"),
                  padding: 0,
                  clickButton: () {
                    context.read<SupportBloc>().add(SubmitButton(
                        bodyCreateSupport: createSupport, context: context));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

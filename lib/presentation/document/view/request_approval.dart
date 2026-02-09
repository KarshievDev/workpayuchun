import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/document/view/preview_of_noc.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_app_bar.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_drop_down.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_upload_file.dart';
import '../../../res/nav_utail.dart';
import '../../../res/widgets/custom_button.dart';
import '../../../res/widgets/date_picker_widget.dart';
import '../../profile/view/content/custom_text_field_with_title.dart';

class RequestApproval extends StatelessWidget {
  const RequestApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              const CustomAppBar(title: "Request Approval",),
              CustomDocumentTypeDropDown(items: const [], title: "Template Type",hint: "Choose A Template",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              CustomTextField(title: "NOC Body", hints: "Write say something..", maxLine: 3,
                onData: (data) {},
              ),
              const SizedBox(height: 10,),
              const Text("Valid Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
              CustomDatePicker(label:DateFormat('yyyy-MM-dd').format(DateTime.now()),
                onDatePicked: (DateTime date) {
                },
              ),
              const SizedBox(height: 10,),
              CustomTextField(title: "NOC Footer", hints: "Write say something..", maxLine: 3,
                onData: (data) {},
              ),
              const SizedBox(height: 10,),
              CustomDocumentTypeDropDown(items: const [], title: "Authorized Person",hint: "Choose A Authorized Person",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              const CustomUploadFile(title: "Choose Sill",),
              const SizedBox(height: 10,),
              const CustomUploadFile(title: "Choose Signature",),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(0)),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Expanded(
              child: CustomHButton(
                textColor: colorPrimary,
                backgroundColor: Colors.blue.shade100,
                title: "preview".tr(),
                padding: 5,
                clickButton: () {
                  NavUtil.navigateScreen(context, const PreviewOfNoc());
                },
              ),
            ),
            Expanded(
              child: CustomHButton(
                title: "Submit".tr(),
                padding: 5,
                clickButton: () {
                  // NavUtil.navigateScreen(context, const DocumentRequestedList());
                },
              ),
            ),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/system_report/view/resigned_or_terminated_list.dart';
import '../../../res/nav_utail.dart';
import '../../../res/widgets/custom_button.dart';
import '../../../res/widgets/date_picker_widget.dart';
import '../../document/view/content/custom_app_bar.dart';
import '../../document/view/content/custom_drop_down.dart';
import '../../profile/view/content/custom_text_field_with_title.dart';

class SystemReportPage extends StatelessWidget {
  const SystemReportPage({super.key});

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
              const CustomAppBar(title: "System Report",),
              CustomTextField(title: "Employee Name", value: '', hints: "Employee Name",
                onData: (data) {
                },
              ),
              const SizedBox(height: 10,),
              CustomDocumentTypeDropDown(items: const [], title: "Document Type",hint: "Select Document",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              CustomDocumentTypeDropDown(items: const [], title: "Department",hint: "Select Department",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              CustomDocumentTypeDropDown(items: const [], title: "Shift",hint: "Select Shift",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              const Text("Resignation Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
              CustomDatePicker(label:DateFormat('yyyy-MM-dd').format(DateTime.now()),
                onDatePicked: (DateTime date) {
                },
              ),
              const SizedBox(height: 10,),
              CustomDocumentTypeDropDown(items: const [], title: "Exit Protocol",hint: "Maintained",
                onChange: (department) {},
              ),
              const SizedBox(height: 10,),
              CustomTextField(title: "Last Working Day", value: '', hints: "22",
                onData: (data) {
                },
              ),
              const SizedBox(height: 10,),
              CustomTextField(title: "Reasons", hints: "Write say something..", maxLine: 3,
                onData: (data) {},
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding:  EdgeInsets.all(8.0.r),
          child: CustomHButton(
            title: "Submit".tr(),
            padding: 16,
            clickButton: () {
              NavUtil.navigateScreen(context, const ResignedOrTerminatedList());
            },
          ),
        ),
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_app_bar.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../../res/widgets/custom_button.dart';
import 'document_request_with_filter.dart';
import 'image_view.dart';

class PreviewOfNoc extends StatelessWidget {
  const PreviewOfNoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomAppBar(title: "Preview Of NOC",),
          ),
          Expanded(child: InkWell(
              onTap: (){
                NavUtil.navigateScreen(context, const ImageView());
              },
              child: Image.asset("assets/images/img_noc.png")))
        ],
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
                title: "Back".tr(),
                padding: 5,
                clickButton: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: CustomHButton(
                title: "Send".tr(),
                padding: 5,
                clickButton: () {
                  NavUtil.navigateScreen(context, const DocumentRequestWithFilter());
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

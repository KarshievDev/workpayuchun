import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class BreakRemarksContent extends StatelessWidget {
  final int breakId;
  final String breakType;

  const BreakRemarksContent({super.key, required this.breakId,required this.breakType});

  @override
  Widget build(BuildContext context) {
    final body = StoreRemarksBody();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Remarks".tr(),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomHButton(
                title: "submit".tr(),
                padding: 16,
                clickButton: () {
                  if (formKey.currentState?.validate() == true) {
                    body.type = RemarkType.breaks;
                    body.id = breakId;
                    context.read<BreakBloc>().add(RemarkEvent(body: body, context: context));
                  }
                },
              )),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            Text(
              "how_was_your_launch".tr(args: [breakType]),
              style: TextStyle(fontSize: 18.r),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextField(
                title: "remarks".tr(),
                hints: "write_here".tr(),
                maxLine: 5,
                errorMsg: "field_cannot_be_empty".tr(),
                onData: (data) {
                  body.remark = data;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

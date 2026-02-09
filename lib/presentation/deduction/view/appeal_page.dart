import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/deduction/bloc/deduction/deduction_cubit.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/deduction_info_left_widget.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class AppealPage extends StatelessWidget {
  final Deduction? deduction;

  const AppealPage({super.key, this.deduction});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final appealController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appeal",
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: DeductionInfoLeftWidget(
                      isAppeal: false,
                    ),
                  ),
                  const SizedBox(height: 100, child: VerticalDivider(width: 20, thickness: 1, color: Colors.black)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deduction?.month ?? "N/A",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deduction?.amount ?? "N/A",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deduction?.considerAmount ?? "N/A",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deduction?.isAppealed ?? "N/A",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                title: "Appeal",
                hints: "Write say something..",
                errorMsg: "*Required field",
                maxLine: 4,
                controller: appealController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: CustomHButton(
            title: "Submit".tr(),
            isLoading: context.watch<DeductionCubit>().state.status == NetworkStatus.loading,
            padding: 16,
            clickButton: () async {
              if (formKey.currentState?.validate() == true) {
                context
                    .read<DeductionCubit>()
                    .submitAppeal(context: context, appealController: appealController, appealId: deduction?.id);
              }
            },
          ),
        ),
      ),
    );
  }
}

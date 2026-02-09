import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'create_complain_content.dart';

class CreateComplainPage extends StatelessWidget {
  const CreateComplainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "create_complain".tr(),
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CreateComplainContent(formKey:formKey),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: CustomHButton(
            title: "Submit".tr(),
            isLoading: context.watch<ComplainBloc>().state.status == NetworkStatus.loading,
            padding: 16,
            clickButton: () async {
              if(formKey.currentState?.validate() == true){
                context.read<ComplainBloc>().submitComplain(context: context);
              }
            },
          ),
        ),
      ),
    );
  }
}


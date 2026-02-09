import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/document/bloc/document_bloc.dart';
import '../../../res/widgets/custom_button.dart';
import 'content/document_request_content.dart';

class CreateDocumentRequestPage extends StatelessWidget {
  const CreateDocumentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "documents_request".tr(),
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: DocumentRequestContent(),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: CustomHButton(
            title: "Submit".tr(),
            isLoading: context.watch<DocumentBloc>().state.status == NetworkStatus.loading,
            padding: 16,
            clickButton: () {
              context.read<DocumentBloc>().add(SubmitButton(context: context));
            },
          ),
        ),
      ),
    );
  }
}


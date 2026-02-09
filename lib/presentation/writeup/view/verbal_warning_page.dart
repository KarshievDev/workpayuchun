import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/verbal_wraning/verbal_warning_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'content/create_verbal_warning_page.dart';
import 'content/verbal_warning_content.dart';

class VerbalWarningPage extends StatelessWidget {
  const VerbalWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final verbalWarningBloc = instance<VerbalWarningBlocFactory>();
    final admin = globalState.get(isAdmin);
    final hr = globalState.get(isHR);

    return BlocProvider(
      create: (_) => verbalWarningBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(
            "verbal_warning".tr(),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: const VerbalWarningContent(),
        bottomNavigationBar: ( admin || hr) ? Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Builder(
              builder: (context) {
                return CustomHButton(
                  title: "create_verbal_warning".tr(),
                  clickButton: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                value: context.read<VerbalWarningBloc>(), child: const CreateVerbalWarningPage())));
                  },
                );
              },
            ),
          ),
        ) : const SizedBox.shrink(),
      ),
    );
  }
}

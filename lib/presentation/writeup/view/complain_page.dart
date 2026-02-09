import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/view/content/create_complain_page.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'content/complain_content.dart';

class ComplainPage extends StatelessWidget {
  const ComplainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final complainBloc = instance<ComplainBlocFactory>();
    final admin = globalState.get(isAdmin);
    final hr = globalState.get(isHR);

    return BlocProvider(
      create: (_) => complainBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(
            "complains".tr(),
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        body: const ComplainContent(),
        bottomNavigationBar: ( admin || hr) ? Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Builder(
              builder: (context) {
                return CustomHButton(
                  title: "create_complain".tr(),
                  clickButton: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                value: context.read<ComplainBloc>(), child: const CreateComplainPage())));
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

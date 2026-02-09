import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart' show CustomTextField;
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/presentation/visit/view/content/visit_employee_info.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class CreateVisitPage extends StatelessWidget {
  const CreateVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    BodyCreateVisit bodyCreateVisit = BodyCreateVisit();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                return CustomHButton(
                  title: "create_visit".tr(),
                  padding: 16,
                  isLoading: state.status == NetworkStatus.loading,
                  clickButton: () {
                    if (formKey.currentState!.validate() && state.status == NetworkStatus.success) {
                      bodyCreateVisit.userId = user?.user?.id;
                      bodyCreateVisit.date = state.currentDate;
                      context.read<VisitBloc>().add(
                        CreateVisitEvent(bodyCreateVisit: bodyCreateVisit, context: context),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
        appBar: AppBar(title: Text(tr("create_visit"))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VisitEmployeeInfo(user: user),
                CustomTextField(
                  title: 'title*'.tr(),
                  hints: tr("give_a_title_to_your_visit"),
                  errorMsg: "field_cannot_be_empty".tr(),
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyCreateVisit.title = data;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: tr("description_optional"),
                  hints: "write_a_note".tr(),
                  maxLine: 5,
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyCreateVisit.description = data;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

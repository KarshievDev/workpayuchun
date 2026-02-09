import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';
import '../../bloc/visit_bloc.dart';

class UpdateVisit extends StatelessWidget {
  final int visitID;

  const UpdateVisit({super.key, required this.visitID});

  @override
  Widget build(BuildContext context) {
    BodyUpdateVisit bodyUpdateVisit = BodyUpdateVisit();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  return CustomHButton(
                    title: "update_visit".tr(),
                    isLoading: state.status == NetworkStatus.loading,
                    padding: 16,
                    clickButton: () {
                      if (formKey.currentState!.validate() &&
                          state.status == NetworkStatus.success) {
                        bodyUpdateVisit.id = visitID;
                        context.read<VisitBloc>().add(VisitUpdateEvent(
                            context: context,
                            bodyUpdateVisit: bodyUpdateVisit));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title: Text(tr("update_visit")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CustomTextField(
                  title: 'title*'.tr(),
                  hints: tr("give_a_title_to_your_visit"),
                  errorMsg: "field_cannot_be_empty".tr(),
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyUpdateVisit.title = data;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  title: tr("description_optional"),
                  hints: "write_a_note".tr(),
                  maxLine: 5,
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyUpdateVisit.description = data;
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

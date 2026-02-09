import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';
import '../../bloc/visit_bloc.dart';

class VisitCancelPage extends StatelessWidget {
  final int visitId;

  const VisitCancelPage({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    BodyVisitCancel bodyVisitCancel = BodyVisitCancel();
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
                    title: "cancel_visit".tr(),
                    padding: 16,
                    isLoading: state.status == NetworkStatus.loading,
                    clickButton: () {
                      if (formKey.currentState!.validate() &&
                          state.status == NetworkStatus.success) {
                        bodyVisitCancel.visitId = visitId;
                        bodyVisitCancel.status = "cancelled";
                        bodyVisitCancel.latitude = state.latitude.toString();
                        bodyVisitCancel.longitude = state.longitude.toString();
                        context.read<VisitBloc>().add(VisitCancelEvent(
                            context: context,
                            bodyVisitCancel: bodyVisitCancel));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title: Text(tr("why_do_you_want_to_cancel_the_visit")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomTextField(
            title: tr("note"),
            hints: "write_a_cancellation_note".tr(),
            maxLine: 5,
            errorMsg: "give_a_note.Field_cannot_be_empty".tr(),
            onData: (data) {
              if (kDebugMode) {
                print(data);
              }
              bodyVisitCancel.cancelNote = data;
            },
          ),
        ),
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/visit/bloc/visit_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class VisitNotePage extends StatelessWidget {
  final int visitID;

  const VisitNotePage({super.key, required this.visitID});

  @override
  Widget build(BuildContext context) {
    BodyVisitNote bodyVisitNote = BodyVisitNote();
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
                    title: "next".tr(),
                    isLoading: state.status == NetworkStatus.loading,
                    padding: 16,
                    clickButton: () {
                      if (formKey.currentState!.validate() && state.status == NetworkStatus.success) {
                        bodyVisitNote.visitId = visitID;
                        context.read<VisitBloc>().add(VisitCreateNoteEvent(
                            bodyVisitNote: bodyVisitNote, context: context));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title: Text("visit_note".tr()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomTextField(
            title: tr("note"),
            hints: "Please_write_a_note".tr(),
            maxLine: 5,
            errorMsg: "give_a_note.Field_cannot_be_empty".tr(),
            onData: (data) {
              if (kDebugMode) {
                print(data);
              }
              bodyVisitNote.note = data;
            },
          ),
        ),
      ),
    );
  }
}

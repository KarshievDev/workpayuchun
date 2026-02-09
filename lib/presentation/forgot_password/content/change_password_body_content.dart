import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class ChangePasswordBodyContent extends StatelessWidget {
  final String? email;
  const ChangePasswordBodyContent({
    super.key,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    ForgotPasswordBody forgotPasswordBody = ForgotPasswordBody();
    return Form(
      key: formKey,
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tr("reset_your_password"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${tr("a_code_has_been_sent_to")} $email ${tr("use_the_code_here")}",
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: tr("enter_code"),
                      labelStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      forgotPasswordBody.code = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: tr("new_password"),
                      labelStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      forgotPasswordBody.password = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'confirm_password'.tr(),
                      labelStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      forgotPasswordBody.passwordConfirmation = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                CustomHButton(
                  padding: 0,
                  isLoading: state.status == NetworkStatus.loading,
                  title: tr("reset_password"),
                  backgroundColor: colorPrimary,
                  clickButton: () {
                    if (formKey.currentState!.validate()) {
                      forgotPasswordBody.email = email;
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ForgotPassword(forgotPasswordBody, context));
                    }
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

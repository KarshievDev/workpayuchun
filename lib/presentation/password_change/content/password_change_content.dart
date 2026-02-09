import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/forgot_password/view/forget_password.dart';
import 'package:strawberryhrm/presentation/password_change/bloc/password_change_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class PasswordChangeContent extends StatefulWidget {
  const PasswordChangeContent({super.key});

  @override
  State<PasswordChangeContent> createState() => _PasswordChangeContentState();
}

class _PasswordChangeContentState extends State<PasswordChangeContent> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    PasswordChangeBody passwordChangeBody = PasswordChangeBody();
    final user = context.read<AuthenticationBloc>().state.data;
    return Form(
      key: formKey,
      child: BlocBuilder<PasswordChangeBloc, PasswordChangeState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: tr("current_password"),
                      labelStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      passwordChangeBody.currentPassword = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: tr("new_password"),
                      labelStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      passwordChangeBody.password = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: tr("Re_type_new_password"),
                      labelStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      passwordChangeBody.passwordConfirmation = value;
                    },
                    validator: (val) =>
                        val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomHButton(
                  isLoading: state.status == NetworkStatus.loading,
                  padding: 0,
                  backgroundColor: colorPrimary,
                  title: tr("change_password"),
                  clickButton: () {
                    passwordChangeBody.userId = user?.user?.id;
                    if (formKey.currentState!.validate()) {
                      context
                          .read<PasswordChangeBloc>()
                          .add(PasswordChange(passwordChangeBody, context));
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    NavUtil.navigateScreen(context, const ForgetPasswordScreen());
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tr("forgot_password"),
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

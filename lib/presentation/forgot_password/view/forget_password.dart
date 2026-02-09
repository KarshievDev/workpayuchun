import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordBody forgotPasswordBody = ForgotPasswordBody();
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
          metaClubApiClient: MetaClubApiClient(
              httpService: instance())),
      child: Form(
        key: formKey,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                tr("forget_password"),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("enter_your_email_address_to_reset_your_password"),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: tr("enter_your_email"),
                        labelStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onChanged: (value) {
                        forgotPasswordBody.email = value;
                      },
                      validator: (val) =>
                          val!.isEmpty ? "field_cannot_be_empty".tr() : null,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                    return CustomHButton(
                      padding: 0,
                      isLoading: state.status == NetworkStatus.loading,
                      title: tr("send_verification_code"),
                      backgroundColor: colorPrimary,
                      clickButton: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(
                              GetVerificationCode(
                                  forgotPasswordBody.email.toString(),
                                  context));
                        }
                      },
                    );
                  }),
                ],
              ),
            )),
      ),
    );
  }
}

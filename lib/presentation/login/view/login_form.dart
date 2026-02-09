import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/forgot_password/view/forget_password.dart';
import 'package:strawberryhrm/presentation/onboarding/view/onboarding_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../../res/dialogs/custom_dialogs.dart';
import '../bloc/login_bloc.dart';
import '../models/email.dart';
import '../models/password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginBloc>().formKey,
      child: Center(
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (oldState, newState) => oldState.loginAction == LoginAction.login,
          listener: (context, state) {
            if (state.status.isFailure) {
              showLoginDialog(
                  context: context,
                  isSuccess: false,
                  message: state.failure!.isSuccess
                      ? 'Authentication successful'
                      : 'Authentication failed\n${state.failure!.meaningfulMessage}');
            }
            if (state.status.isCanceled) {
              showLoginDialog(context: context, isSuccess: false, message: '${state.user?.user?.name}');
            }
            if (state.status.isSuccess) {
              showLoginDialog(
                  context: context,
                  isSuccess: true,
                  message: '${state.user?.user?.name}',
                  body: 'Authentication Successful');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    "assets/images/app_icon.png",
                    height: 130.0,
                    width: 130.0,
                  )),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text('login_your_account'.tr(),style: const TextStyle(fontSize: 20.0)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const _EmailInput(),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const _PasswordInput(),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(context, const ForgetPasswordScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          tr("forgot_password"),
                          style: TextStyle(color: colorPrimary, fontSize: 10.r, fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const _LoginButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  const _SelectCompanyButton(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('email_text_field'),
          onChanged: (phone) => context.read<LoginBloc>().add(LoginEmailChange(email: phone)),
          validator: (value) => state.email.validator(value ?? '')?.text(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(fontSize: 12.r),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 12.r),
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)), borderSide: BorderSide(color: Colors.grey)),
            prefixIcon: Image.asset('assets/images/email_icon.png', scale: 3, color: mainColor),
            prefixIconColor: mainColor,
            errorText: state.email.displayError != null ? 'Invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('password_text_field'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChange(password: password)),
          validator: (value) => state.password.validator(value ?? '')?.text(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: state.isObscure,
          style: TextStyle(fontSize: 12.r),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 12.r),
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)), borderSide: BorderSide(color: Colors.grey)),
            suffixIcon: IconButton(
              icon: Icon(
                state.isObscure ? Icons.visibility_off : Icons.visibility,
                color: colorPrimary,
              ),
              onPressed: () {
                context.read<LoginBloc>().add(const OnObscureEvent());
              },
            ),
            prefixIcon: Image.asset('assets/images/password_lock_icon.png', scale: 3, color: mainColor),
            prefixIconColor: mainColor,
            errorText: state.password.displayError != null ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                height: 40.0.r,
                child: ElevatedButton(
                  onPressed: () {
                    if (context.read<LoginBloc>().formKey.currentState?.validate() == true) {
                      context.read<LoginBloc>().add(const LoginSubmit());
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Branding.colors.primaryDark),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 14.r),
                  ),
                ),
              );
      },
    );
  }
}

class _SelectCompanyButton extends StatelessWidget {
  const _SelectCompanyButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        NavUtil.replaceScreen(context, const OnboardingPage());
      },
      child: Text(
        'Back',
        style: TextStyle(fontSize: 14.r),
      ),
    );
  }
}

extension on PhoneValidationError {
  String text() {
    switch (this) {
      case PhoneValidationError.empty:
        return 'Please enter on email';
    }
  }
}

extension on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Please enter on phone';
    }
  }
}

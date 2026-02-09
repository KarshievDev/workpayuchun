import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_framework/hrm_framework.dart';
import '../bloc/login_bloc.dart';
import 'login_form.dart';

typedef LoginPageFactory = LoginPage Function();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) => LoginBloc(
                chatService: ChatService(),
                getDeviceIdUseCase: instance.get<GetDeviceIdUseCase>(),
                getDeviceNameUseCase: instance.get<GetDeviceNameUseCase>(),
                loginWIthEmailPasswordUseCase: instance(),
              ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/forgot_password/content/change_password_body_content.dart';

class ChangePassword extends StatefulWidget {
  final String email;

  const ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangePasswordBodyContent(
          email: widget.email,
        ));
  }
}

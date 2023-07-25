import 'package:fablearner_app/design/screens/login/login_button.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Login Screen",
            style: AppTextStyles.displayMedium,
          ),
        ),
        body: const Center(
          child: LoginButton(),
        ));
  }
}

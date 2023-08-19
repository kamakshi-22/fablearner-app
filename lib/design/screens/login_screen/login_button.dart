import 'package:fablearner_app/design/screens/login_screen/login_sheet.dart';
import 'package:fablearner_app/design/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/utils/utils.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void _showLoginBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(appCircularBorderRadius),
          ),
        ),
        builder: (context) {
          return LoginBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: AppLayout.getHeight(appDefaultSpacing * 2),
        width: AppLayout.getScreenWidth() * 0.8,
        child: ActionButton(
          onPressed: _showLoginBottomSheet,
          text: "Login",
        ));
  }
}

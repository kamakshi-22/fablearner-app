import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/design/screens/login/components/login_sheet.dart';
import 'package:fablearner_app/design/screens/nav/nav_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
      child: ElevatedButton(
        onPressed: _showLoginBottomSheet,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appCircularBorderRadius),
            ),
            backgroundColor: AppColors.primaryColor),
        child: Text(
          "Login".toUpperCase(),
          style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    );
  }
}

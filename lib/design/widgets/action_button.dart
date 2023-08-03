import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const ActionButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appCircularBorderRadius),
            ),
            backgroundColor: AppColors.primaryColor),
        child: Text(
          text.toUpperCase(),
          style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      );
  }
}
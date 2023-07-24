import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String text;
  const ErrorScreen({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
            child: Text(
          text,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.errorColor,
          ),
        )));
  }
}

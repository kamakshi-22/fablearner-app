
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppLinearProgressIndicator extends StatelessWidget {
  const AppLinearProgressIndicator({
    super.key,
    required this.progressPercent,
  });

  final int progressPercent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(appProgressIndicatorHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: LinearProgressIndicator(
          backgroundColor: AppColors.accentColor,
          color: AppColors.successColor,
          minHeight: appProgressIndicatorHeight,
          value: progressPercent.toDouble(),
        ),
      ),
    );
  }
}

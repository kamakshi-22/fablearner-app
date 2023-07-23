import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void printIfDebug(text) {
  if (kDebugMode) {
    print(text);
  }
}

Text errorText(String text) {
  return Text(
    text,
    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.errorColor),
  );
}

SnackBar showErrorSnackBar(String message) {
  return SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Error",
          style: AppTextStyles.labelLarge
              .copyWith(color: AppColors.backgroundColor),
        ),
        Gap(AppLayout.getHeight(4)),
        Text(
          message,
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.backgroundColor),
        ),
      ],
    ),
    duration: const Duration(seconds: 4),
    backgroundColor: AppColors.errorColor,
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar showSuccessSnackBar(String message) {
  return SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Success",
          style: AppTextStyles.labelLarge
              .copyWith(color: AppColors.backgroundColor),
        ),
        Gap(AppLayout.getHeight(4)),
        Text(
          message,
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.backgroundColor),
        ),
      ],
    ),
    duration: const Duration(seconds: 4),
    backgroundColor: AppColors.successColor,
    behavior: SnackBarBehavior.floating,
  );
}

import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

void showSuccessToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: AppColors.successColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: AppColors.errorColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoadingIndicator(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
            strokeWidth: 6,
          ),
        );
      });
}

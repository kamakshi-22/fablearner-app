import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
class QRInstructionBox extends StatelessWidget {
  const QRInstructionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: AppLayout.getHeight(40),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: appDefaultPadding),
          alignment: Alignment.center,
          height: AppLayout.getScreenHeight() * 0.1,
          width: AppLayout.getScreenWidth() * 0.8,
          decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius:
                  BorderRadius.circular(appCircularBorderRadius)),
          child: Text(
            "Scan the QR code by aligning it within the frame.",
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

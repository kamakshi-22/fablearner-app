import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: AppLayout.getScreenHeight() * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(appCircularBorderRadius))),
        ),
        Positioned(
          bottom: AppLayout.getHeight(-40),
          right: AppLayout.getWidth(-20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: appDefaultPadding),
            height: AppLayout.getHeight(180),
            width: AppLayout.getWidth(290),
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                'assets/images/open-book.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: appDefaultPadding,
              right: appDefaultPadding * 4,
              top: appDefaultPadding / 2),
          child: RichText(
            text: TextSpan(
              text: 'Teach your child to  ',
              style: AppTextStyles.displaySmall
                  .copyWith(color: AppColors.primaryColor),
              children: [
                TextSpan(
                  text: 'read with ',
                  style: AppTextStyles.displaySmall
                      .copyWith(color: AppColors.primaryColor),
                ),
                TextSpan(
                  text: 'engaging lessons ',
                  style: AppTextStyles.displaySmall
                      .copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

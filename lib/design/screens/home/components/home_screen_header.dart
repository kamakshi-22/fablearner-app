import 'package:fablearner_app/design/screens/home/components/header_card.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreenHeader extends StatelessWidget {
  final String username;
  const HomeScreenHeader({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appDefaultPadding,
        vertical: appDefaultPadding / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Text(username, style: AppTextStyles.headlineMedium),
          Gap(AppLayout.getHeight(appDefaultSpacing)),
          const HeaderCard(),
          Gap(AppLayout.getHeight(appDefaultSpacing * 2)),
          Text(
            "Learn with our best courses!",
            maxLines: 2,
            style: AppTextStyles.headlineMedium,
          ),
          Gap(AppLayout.getHeight(10)),
        ],
      ),
    );
  }
}

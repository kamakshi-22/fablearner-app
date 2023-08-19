import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/home_screen/home_header_card.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String? userDisplayName = UserPreferences.getUserDisplayName();
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
          Text(userDisplayName!, style: AppTextStyles.headlineMedium),
          Gap(AppLayout.getHeight(appDefaultSpacing)),
          const HomeHeaderCard(),
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

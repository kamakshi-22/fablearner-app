import 'dart:math';

import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/login_screen/login_screen.dart';
import 'package:fablearner_app/design/widgets/action_button.dart';
import 'package:fablearner_app/providers/drawer_state_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  void _handleLogout(BuildContext context) {
    UserPreferences.clearUserDetails();
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const LoginScreen(),
        type: PageTransitionType.fade,
        duration: const Duration(seconds: 2),
      ),
      (route) => false,
    );
    Provider.of<DrawerStateProvider>(context, listen: false)
        .setDrawerState(false);
  }

  void _handleTapMenuItem(BuildContext context, Uri websiteUri) {
    launchUrl(websiteUri, mode: LaunchMode.inAppWebView);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Handle taps outside the drawer to close the drawer
            Navigator.pop(context);
            Provider.of<DrawerStateProvider>(context, listen: false)
                .setDrawerState(false);
          },
          child: Container(
            color: Colors.transparent, // Transparent background to detect taps
          ),
        ),
        Drawer(
          child: Column(
            children: [
              Column(
                children: [
                  buildHeader(context),
                  buildMenuItems(context),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: appDefaultPadding,
                  horizontal: appDefaultPadding * 1.8,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      onPressed: () => _handleLogout(context),
                      text: "Logout",
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    String? userDisplayName = UserPreferences.getUserDisplayName();
    String? userEmail = UserPreferences.getUserEmail();
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: appDefaultPadding,
        vertical: appDefaultPadding,
      ),
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  FontAwesomeIcons.circleUser,
                  color: AppColors.textColor,
                  size: appIconSize * 1.6,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  FontAwesomeIcons.xmark,
                  color: AppColors.textColor,
                  size: appIconSize,
                ),
              )
            ],
          ),
          Gap(appDefaultPadding / 2),
          Text(
            userDisplayName!,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              letterSpacing: 1,
            ),
          ),
          Gap(appDefaultPadding / 4),
          Text(
            userEmail!,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: appDefaultPadding,
          vertical: appDefaultPadding,
        ),
        child: Column(
          children: [
            labelItem('Weekly Meetings', context, meetingsUrl),
            labelItem('Help Desk', context, helpDeskUrl),
          ],
        ));
  }

  Widget labelItem(String text, BuildContext context, String url) {
    final websiteUri = Uri.parse(url);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Transform.rotate(
            angle: pi / 2,
            child: Icon(
              FontAwesomeIcons.solidBookmark,
              color: AppColors.highlightColor,
              size: appIconSize,
            ),
          ),
          Gap(appDefaultPadding),
          InkWell(
            onTap: () {
              Provider.of<DrawerStateProvider>(context, listen: false)
                  .setDrawerState(false);
              _handleTapMenuItem(context, websiteUri);
            },
            child: Text(
              text,
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

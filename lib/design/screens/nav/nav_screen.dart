import 'package:fablearner_app/design/notifications/notifications_screen.dart';
import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/design/screens/qr-scan/qr_scan_screen.dart';
import 'package:fablearner_app/utils/colors.dart';
import 'package:fablearner_app/utils/constants.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);

  final tabBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.qrcode,
    FontAwesomeIcons.solidBell
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: const [HomeScreen(), QRScan(), NotificationsScreen()],
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Container(
                height: AppLayout.getHeight(70),
                decoration: BoxDecoration(
                  color: AppColors.darkColor,
                  borderRadius: BorderRadius.circular(
                    appCircularBorderRadius,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < tabBarIcons.length; i++)
                      IconButton(
                        onPressed: () {
                          pageController.jumpToPage(i);
                        },
                        icon: Icon(
                          tabBarIcons[i],
                          color: currentIndex == i
                              ? AppColors.highlightColor // Active color
                              : AppColors.backgroundColor,
                          size: appIconSize,
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

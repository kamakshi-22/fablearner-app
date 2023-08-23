import 'package:fablearner_app/design/screens/home_screen/home_screen_drawer.dart';
import 'package:fablearner_app/design/screens/notifications_screen/notifications_screen.dart';
import 'package:fablearner_app/design/screens/home_screen/home_screen.dart';
import 'package:fablearner_app/design/screens/qr_scan_screen/qr_scan_screen.dart';
import 'package:fablearner_app/providers/drawer_state_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    final drawerProvider =
        Provider.of<DrawerStateProvider>(context, listen: false);
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
                   drawerProvider.setDrawerState(false);
                },
                children: const [
                  HomeScreen(),
                  QRScanScreen(),
                  NotificationsScreen(),
                ]),
            Consumer<DrawerStateProvider>(
                builder: (context, drawerProvider, child) {
              return Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: drawerProvider.isDrawerOpen
                    ? Container()
                    : Container(
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
              );
            }),
          ],
        ),
      ),
    );
  }
}

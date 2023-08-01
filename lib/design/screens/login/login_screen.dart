import 'package:fablearner_app/design/screens/login/components/login_button.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Transform.flip(
            flipY: true,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1546521343-4eb2c01aa44b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMTgwOTN8MHwxfHNlYXJjaHw0MHx8Ym9va3N8ZW58MHx8fHwxNjkwODY5NzQ0fDA&ixlib=rb-4.0.3&q=80&w=1080'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: appDefaultPadding * 4),
              height: AppLayout.getScreenHeight() * 0.5,
              width: AppLayout.getScreenWidth(),
              //color: Colors.red,
              child: Column(
                children: [
                  Text(
                    "Fab learner".toUpperCase(),
                    style: AppTextStyles.displayMedium,
                  ),
                  Gap(
                    AppLayout.getHeight(appDefaultPadding / 4),
                  ),
                  Text(
                    "Unlock The Joy Of Reading",
                    style: AppTextStyles.titleSmall,
                  ),
                  Gap(
                    AppLayout.getHeight(appDefaultPadding * 2),
                  ),
                  const LoginButton(),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

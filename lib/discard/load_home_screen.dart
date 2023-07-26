/* import 'dart:async';

import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadHomeScreen extends StatelessWidget {
  const LoadHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String token = userProvider.user!.token;
    printIfDebug("token $token");
    String username = userProvider.user!.userDisplayName;
    printIfDebug("username $username");
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: serviceProvider.fetchCoursesData(token),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const LoadingScreen();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const LoadingScreen();
              case ConnectionState.done:
                final courses = snapshot.data as List<CourseModel>;
                if (snapshot.hasError) {
                  printIfDebug(snapshot.error);
                  return const ErrorScreen(
                      text: "Encountered error. Please try again.");
                } else {
                  Future.delayed(Duration.zero, () {
                    Provider.of<CoursesProvider>(context, listen: false)
                        .updateCoursesModel(courses);
                  });
                  return HomeScreen();
                }

              default:
                return const ErrorScreen(text: 'Unknown connection state');
            }
          },
        ),
      ),
    );
  }
}
 */
import 'dart:async';

import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadHomeScreen extends StatelessWidget {
  final String userDisplayName;
  final String authToken;
  const LoadHomeScreen(
      {super.key, required this.authToken, required this.userDisplayName});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: dataProvider.fetchCoursesData(authToken),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const LoadingScreen();
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const LoadingScreen();
            case ConnectionState.done:
              final courses = snapshot.data;
              if (snapshot.hasError) {
                // Handle error
                return ErrorScreen(text: snapshot.error.toString());
              } else {
                return HomeScreen(
                    courses: courses, userDisplayName: userDisplayName);
              }

            default:
              return const ErrorScreen(text: 'Unknown connection state');
          }
        },
      ),
    );
  }
}

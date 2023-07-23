import 'package:fablearner_app/design/screens/lesson/lesson_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadLessonScreen extends StatelessWidget {
  final int lessonId;
  final List<Item> items;
  const LoadLessonScreen(
      {super.key, required this.lessonId, required this.items});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String token = authProvider.authToken;
    return FutureBuilder(
      future: dataProvider.fetchLessonData(lessonId, token),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // Future has not been triggered yet
            return LoadingScreen();
          case ConnectionState.active:
          case ConnectionState.waiting:
            // Future is still running
            return LoadingScreen();
          case ConnectionState.done:
            // Future has completed
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final lessonData = snapshot.data;
              return LessonScreen(
                lesson: lessonData!,
                lessonItems: items,
              );
            }
          default:
            return const ErrorScreen(text: 'Unknown connection state');
        }
      },
    );
  }
}

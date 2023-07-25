import 'package:fablearner_app/design/screens/lesson/lesson_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/data/lesson_provider.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/providers/data/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadLessonScreen extends StatelessWidget {
  final int lessonId;
  final List<Item> items;
  const LoadLessonScreen({
    super.key,
    required this.lessonId,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user!.token;
    return FutureBuilder(
      future: serviceProvider.fetchLessonData(lessonId, token),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const LoadingScreen();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            if (snapshot.hasError) {
              printIfDebug(snapshot.error);
              return const ErrorScreen(
                  text: "Encountered error. Please try again.");
            } else {
              final lesson = snapshot.data as LessonModel;
              Provider.of<LessonProvider>(context,listen: false).updateLessonModel(lesson);
              return LessonScreen(
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

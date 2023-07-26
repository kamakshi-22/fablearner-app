import 'package:fablearner_app/design/screens/lesson/components/mark_finished_button.dart';
import 'package:fablearner_app/design/screens/lesson/lesson_screen.dart';
import 'package:fablearner_app/discard/load_lesson_screen.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:fablearner_app/models/courses_model.dart';

class NextLesson extends StatelessWidget {
  final LessonModel lesson;
  final List<Item> lessonItems;
  const NextLesson({
    super.key,
    required this.lesson,
    required this.lessonItems,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user.token;
    final lessonProvider = Provider.of<LessonProvider>(context);
    return GestureDetector(
      onTap: () {
        try {
          for (int i = 0; i < lessonItems.length; i++) {
            if (lessonItems[i].id == lesson.id) {
              final newLessonId = lessonItems[i + 1].id;
              lessonProvider.fetchLessonModel(newLessonId, token);
            }
          }
        } catch (e) {
          showErrorToast("No more lessons found");
          rethrow;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                "Continue to Next Lesson",
                style: AppTextStyles.labelLarge,
              ),
              Gap(AppLayout.getWidth(appDefaultSpacing / 2)),
              const Icon(
                FontAwesomeIcons.arrowRight,
                size: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:fablearner_app/design/screens/lesson/components/mark_finished_button.dart';
import 'package:fablearner_app/design/screens/lesson/load_lesson_screen.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/providers.dart';
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
    return GestureDetector(
      onTap: () {
        try {
          for (int i = 0; i < lessonItems.length; i++) {
            if (lessonItems[i].id == lesson.id) {
              final newLessonId = lessonItems[i + 1].id;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoadLessonScreen(
                    lessonId: newLessonId, items: lessonItems);
              }));
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

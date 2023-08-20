import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LessonChangeButton extends StatefulWidget {
  const LessonChangeButton({
    super.key,
  });

  @override
  State<LessonChangeButton> createState() => _LessonChangeButtonState();
}

class _LessonChangeButtonState extends State<LessonChangeButton> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = UserPreferences.getUserToken() ?? userProvider.user.token;
    final lessonProvider = Provider.of<LessonProvider>(context);
    final lesson = lessonProvider.lessonModel;
    final courseProvider = Provider.of<CoursesProvider>(context);
    // Get the Ids
    final lessonId = lesson.id;
    final courseId = lesson.assigned.course.id;

    // Find the course
    final course = courseProvider.coursesModel
        .where((course) => course.id.toString() == courseId)
        .first;

    // Find the section containing the lesson
    final sectionWithLesson = course.sections.firstWhere(
      (section) => section.items.any((item) => item.id == lessonId),
    );

    // Get the items
    final items = sectionWithLesson.items;
    printIfDebug("Number of items in the section: ${items.length}");
    return GestureDetector(
        onTap: () async {
          try {
            showLoadingIndicator(context);
            for (int i = 0; i < items.length; i++) {
              if (items[i].id == lesson.id) {
                final newLessonId = items[i + 1].id;
                await lessonProvider.fetchLessonModel(newLessonId, token);
              }
            }
          } catch (e) {
            showErrorToast("No more lessons found");
            throw Exception("Now more lessons found");
          } finally {
            await Future.delayed(const Duration(milliseconds: 300));
            if(mounted){
              Navigator.of(context).pop();
            }
            
          }
        },
        child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: appDefaultPadding),
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
            )));
  }
}

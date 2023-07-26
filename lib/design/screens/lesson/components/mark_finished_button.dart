import 'package:fablearner_app/design/widgets/progress_indicator.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/finish_lesson_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkFinishedButton extends StatelessWidget {
  final LessonModel lesson;
  const MarkFinishedButton({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = lesson.results.status.contains("completed");

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user.token;

    final finishLessonProvider = Provider.of<FinishLessonProvider>(context);
    final lessonProvider = Provider.of<LessonProvider>(context);
    final courseProvider = Provider.of<CoursesProvider>(context);

    return finishLessonProvider.isLoading
        ? AppLoadingIndicator()
        : Container(
            padding: EdgeInsets.symmetric(vertical: appDefaultPadding / 2),
            child: ElevatedButton(
              onPressed: () async {
                if (finishLessonProvider.isLoading || isCompleted) return;
                try {
                  await finishLessonProvider.markLessonFinished(
                      lesson.id, token);
                  lessonProvider.fetchLessonModel(lesson.id, token);
                  courseProvider.fetchCourseModel(token);
                  printIfDebug(finishLessonProvider.finishlessonModel.message);
                  final message =
                      finishLessonProvider.finishlessonModel.message;
                  final status = finishLessonProvider.finishlessonModel.status;

                  if (status.contains("error")) {
                    showErrorToast(message);
                  } else {
                    showSuccessToast(message);
                  }
                } catch (e) {
                  showErrorToast("Something went wrong");
                  rethrow;
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(appCircularBorderRadius),
                  ),
                  backgroundColor: isCompleted
                      ? AppColors.accentColor
                      : AppColors.successColor),
              child: Text(
                "Mark Finished",
                style: AppTextStyles.labelLarge,
              ),
            ),
          );
  }
}

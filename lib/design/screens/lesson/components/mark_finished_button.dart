import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/providers/data/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkFinishedButton extends StatelessWidget {
  final LessonModel lesson;
  const MarkFinishedButton({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user!.token;
    final bool isCompleted = lesson.results.status.contains("completed");
    return ElevatedButton(
      onPressed: () async {
        try {
          if (isCompleted) {
            return;
          } else {
            final response =
                await serviceProvider.finishLesson(lesson.id.toString(), token);
            //if (!mounted) return;
            if (response.status.contains("error")) {
              showErrorToast(response.message);
            } else {
              await serviceProvider.fetchCoursesData(token);
              serviceProvider.fetchLessonData(lesson.id, token);
              //if (!mounted) return;
              showSuccessToast(response.message);
            }
          }
        } catch (e) {
          rethrow;
        }
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appCirclularBorderRadius),
          ),
          backgroundColor:
              isCompleted ? AppColors.accentColor : AppColors.successColor),
      child: Text(
        "Mark Finished",
        style: AppTextStyles.labelLarge,
      ),
    );
  }
}

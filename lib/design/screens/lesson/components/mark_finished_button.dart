import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/finish_lesson_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkFinishedButton extends StatefulWidget {
  const MarkFinishedButton({
    super.key,
    required this.lesson,
  });

  final LessonModel lesson;

  @override
  State<MarkFinishedButton> createState() => _MarkFinishedButtonState();
}

class _MarkFinishedButtonState extends State<MarkFinishedButton> {
  @override
  Widget build(BuildContext context) {
    final finishLessonProvider = Provider.of<FinishLessonProvider>(context);
    final lessonProvider = Provider.of<LessonProvider>(context);
    final courseProvider = Provider.of<CoursesProvider>(context);
    bool isCompleted = widget.lesson.results.status.contains("completed");

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user.token;

    return Container(
      padding: EdgeInsets.symmetric(vertical: appDefaultPadding / 2),
      child: ElevatedButton(
        onPressed: () async {
          if (finishLessonProvider.isLoading || isCompleted) return;
          try {
            showLoadingIndicator(context);
            await finishLessonProvider.markLessonFinished(
                widget.lesson.id, token);
            lessonProvider.fetchLessonModel(widget.lesson.id, token);
            courseProvider.fetchCourseModel(token);
            printIfDebug(finishLessonProvider.finishlessonModel.message);
            final message = finishLessonProvider.finishlessonModel.message;
            final status = finishLessonProvider.finishlessonModel.status;

            if (status.contains("error")) {
              showErrorToast(message);
            } else {
              showSuccessToast(message);
            }
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            showErrorToast("Something went wrong");
            rethrow;
          }
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appCircularBorderRadius),
            ),
            backgroundColor:
                isCompleted ? AppColors.accentColor : AppColors.successColor),
        child: Text(
          "Mark Finished",
          style: AppTextStyles.labelLarge,
        ),
      ),
    );
  }
}

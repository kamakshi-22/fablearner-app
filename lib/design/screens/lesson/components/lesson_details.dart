import 'package:fablearner_app/design/screens/lesson/components/mark_finished_button.dart';
import 'package:fablearner_app/design/screens/lesson/components/next_lesson.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:fablearner_app/models/courses_model.dart';

class LessonDetails extends StatelessWidget {
  final LessonModel lesson;
  final List<Item> lessonItems;
  const LessonDetails({
    super.key,
    required this.lesson,
    required this.lessonItems,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = lesson.results.status.contains("completed");
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: AppLayout.getScreenHeight() * 0.4),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appCircularBorderRadius),
          topRight: Radius.circular(appCircularBorderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(appDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLessonDetails(),
            MarkFinishedButton(lesson: lesson),
            if (!isCompleted)
              Text(
                "** This can only be marked once! **",
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.errorColor),
              ),
            const Spacer(),
            NextLesson(
              lesson: lesson,
              lessonItems: lessonItems,
            ),
          ],
        ),
      ),
    );
  }

  Column buildLessonDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lesson.name,
          style: AppTextStyles.displaySmall,
        ),
        Gap(AppLayout.getHeight(appDefaultSpacing)),
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.chevronDown,
              size: 20,
            ),
            Gap(AppLayout.getWidth(8)),
            Text(
              lesson.assigned.course.title,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        Gap(AppLayout.getHeight(appDefaultSpacing)),
        Text(
          lesson.assigned.course.content,
          style: AppTextStyles.bodyMedium,
        ),
        Gap(AppLayout.getHeight(appDefaultSpacing)),
      ],
    );
  }
}

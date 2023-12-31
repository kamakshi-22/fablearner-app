import 'package:fablearner_app/design/widgets/linear_progress_indicator.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionProgressHeader extends StatelessWidget {
  final dynamic progressPercent;
  final CourseModel course;
  const SectionProgressHeader({
    super.key,
    required this.progressPercent,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final roundedPercent = ((progressPercent * 100).round()) / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Progress",
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.accentColor),
                ),
                Text(
                  "$roundedPercent% completed",
                  style: AppTextStyles.headlineSmall
                      .copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: appCourseImageSize / 2,
              child: Hero(
                tag: "${course.id}",
                child: Image.network(
                  course.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Gap(AppLayout.getHeight(8)),
        /* LINEAR PROGRESS INDICATOR */
        AppLinearProgressIndicator(progressPercent: progressPercent)
      ],
    );
  }
}

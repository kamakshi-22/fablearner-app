import 'package:fablearner_app/design/screens/sections/components/progress_header.dart';
import 'package:fablearner_app/design/screens/sections/components/lesson_item.dart';
import 'package:fablearner_app/design/widgets/progress_indicator.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsScreenBody extends StatefulWidget {
  final CourseModel course;
  final TabController? tabController;
  const SectionsScreenBody({
    super.key,
    required this.course,
    this.tabController,
  });

  @override
  State<SectionsScreenBody> createState() => _SectionsScreenBodyState();
}

class _SectionsScreenBodyState extends State<SectionsScreenBody> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Padding(
      padding:
          EdgeInsets.only(top: AppLayout.getHeight(appCircularBorderRadius)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appCircularBorderRadius),
              topRight: Radius.circular(appCircularBorderRadius),
            )),
        child: TabBarView(
          controller: widget.tabController,
          children: course.sections.map((section) {
            
            final progressPercent = section.percent;
            final lessons = section.items;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: appDefaultPadding,
                    vertical: 20.0,
                  ),
                  child: ProgressHeader(
                    progressPercent: progressPercent,
                    course: course,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final item = lessons[index];
                      return LessonItem(
                        item: item,
                        items: lessons,
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

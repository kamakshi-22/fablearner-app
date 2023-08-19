import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionScreenFloatingActionButton extends StatelessWidget {
  final TabController tabController;
  final CourseModel course;
  const SectionScreenFloatingActionButton(
      {super.key, required this.tabController, required this.course});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        int tabIndex = tabController.index;
        int sectionsLength = course.sections.length - 1;
        if (tabIndex < sectionsLength) {
          tabController.index++;
        }
      },
      child: const Icon(FontAwesomeIcons.chevronRight),
    );
  }
}


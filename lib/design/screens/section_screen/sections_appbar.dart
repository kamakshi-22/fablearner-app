import 'package:fablearner_app/models/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';

class SectionsAppBar extends StatelessWidget {
  final CourseModel course;
  final TabController? tabController;
  const SectionsAppBar(
      {super.key, required this.course, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: AppColors.backgroundColor,
          )),
      title: Text(
        course.name,
        style: AppTextStyles.displaySmall.copyWith(
          color: AppColors.backgroundColor,
        ),
      ),
      bottom: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.backgroundColor,
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.label,
          controller: tabController,
          tabs: buildTabs()),
    );
  }

  List<Widget> buildTabs() {
    List<Widget> list = [];
    final sections = course.sections;
    for (int i = 0; i < sections.length; i++) {
      list.add(Text(
        sections[i].title,
        style: AppTextStyles.titleMedium
            .copyWith(color: AppColors.backgroundColor),
      ));
    }
    return list;
  }
}

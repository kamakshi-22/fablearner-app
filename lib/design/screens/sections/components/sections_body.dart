import 'package:fablearner_app/design/screens/sections/components/progress_header.dart';
import 'package:fablearner_app/design/screens/sections/components/lesson_item.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';

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
          EdgeInsets.only(top: AppLayout.getHeight(appCirclularBorderRadius)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appCirclularBorderRadius),
              topRight: Radius.circular(appCirclularBorderRadius),
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
/* 
  List<Widget> buildTabBarView() {
    List<Widget> list = []; // stores section's items
    final sections = widget.course.sections;
    final progressPercent = sections[widget.tabController!.index].percent;

    for (int i = 0; i < sections.length; i++) {
      final items = sections[i].items; // current section's items
      List<Widget> sectionItemsList = []; // stores widgets for current item
      for (int j = 0; j < items.length; j++) {
        final item = items[j]; // current item
        sectionItemsList.add(
            /* LESSON ITEM */
            LessonItem(
          item: item,
          items: items,
        ));
      }
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: appDefaultPadding, vertical: 20.0),
            child: ProgressHeader(
              progressPercent: progressPercent,
              course: widget.course,
            ),
          ),
          Expanded(
            child: ListView(
              /* LESSONS LIST */
              children: sectionItemsList,
            ),
          ),
        ],
      ));
    }
    return list;
  } */
}

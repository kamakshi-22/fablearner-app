import 'dart:math';

import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/colors.dart';
import 'package:fablearner_app/utils/constants.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final Function() onTap;
  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String completedCourses = course.sections
        .where((section) => section.percent == 100)
        .length
        .toString();
    String totalCourses = course.sections.length.toString();
    print(completedCourses);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.transparent,
              padding: EdgeInsets.only(
                  top: appDefaultPadding * 0.6, right: appDefaultPadding),
            ),
            badgeContent: completedCourses == totalCourses
                ? Icon(
                    FontAwesomeIcons.circleCheck,
                    color: AppColors.successColor,
                    weight: 40,
                  )
                : Column(
                    children: [
                      Text(
                        completedCourses,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      Transform.rotate(
                        angle: 1.96 * pi,
                        child: Container(
                          height: appDefaultSpacing / 8,
                          width: appDefaultSpacing,
                          color: completedCourses == totalCourses
                              ? AppColors.successColor
                              : AppColors.errorColor,
                        ),
                      ),
                      Text(
                        totalCourses,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: appDefaultPadding),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(appCircularBorderRadius),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: appCourseImageSize,
                    child: Hero(
                      tag: "${course.id}",
                      child: Image.network(
                        course.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          course.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelMedium
                              .copyWith(color: AppColors.backgroundColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressIndicator() {
    int? progressPercent;
    for (int i = 0; i < course.sections.length; i++) {
      progressPercent = course.sections[i].percent;
    }
    return SizedBox(
        height: 8,
        width: 30,
        child:
            AppLinearProgressIndicator(progressPercent: progressPercent ?? 0));
  }
}


/* 
List<Widget> buildIndicators() {
    List<Widget> list = [];
    for (int i = 0; i < course.sections.length; i++) {
      list.add((course.sections[i].percent == 100)
          ? Icon(
              FontAwesomeIcons.squareCheck,
              color: AppColors.successColor,
            )
          : Icon(FontAwesomeIcons.square, color: AppColors.successColor));
    }
    return list;
  }

 */
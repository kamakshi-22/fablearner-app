import 'package:fablearner_app/design/screens/home/course_card.dart';
import 'package:fablearner_app/design/screens/sections/sections_screen.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreenBody extends StatelessWidget {
  final List<CoursesModel>? courses;
  final String userDisplayName;
  const HomeScreenBody({
    super.key,
    required this.courses,
    required this.userDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: buildHomeScreenHeader(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
              horizontal: appDefaultPadding, vertical: appDefaultPadding / 2),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
              crossAxisCount: 2,
              crossAxisSpacing: appDefaultSpacing,
              mainAxisSpacing: appDefaultSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: courses!.length,
              (context, index) {
                final course = courses![index];
                return CourseCard(
                  course: course,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SectionsScreen(
                        course: course,
                      );
                    }));
                  },
                );
              },
            ),
          ),
        ),

        /* ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: courses!.length,
          itemBuilder: (context, index) {
            final course = courses![index];
            return CourseCard(
              course: course,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SectionsScreen(
                    course: course,
                  );
                }));
              },
            );
          },
        ), */
      ],
    );
  }

  Padding buildHomeScreenHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appDefaultPadding,
        vertical: appDefaultPadding / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Text(userDisplayName, style: AppTextStyles.headlineMedium),
          Gap(AppLayout.getHeight(appDefaultSpacing)),
          Text(
            "Learn with our best courses!",
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Gap(AppLayout.getHeight(10)),
        ],
      ),
    );
  }
}

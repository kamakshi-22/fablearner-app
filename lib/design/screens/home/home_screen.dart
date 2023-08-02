import 'package:fablearner_app/design/screens/home/components/home_screen_header.dart';
import 'package:fablearner_app/design/screens/home/components/course_card.dart';
import 'package:fablearner_app/design/screens/sections/sections_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';

import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.barsStaggered,
                  color: AppColors.textColor,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "FabLearner",
                  style: AppTextStyles.displaySmall,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final username = userProvider.user.userDisplayName;
                  return HomeScreenHeader(username: username);
                },
              )),
            ),
            SliverPadding(
                padding: EdgeInsets.only(
                    right: appDefaultPadding,
                    left: appDefaultPadding,
                    top: appDefaultPadding / 2,
                    bottom: appDefaultPadding * 4),
                sliver: Consumer<CoursesProvider>(
                  builder: (context, coursesProvider, child) {
                    final courses = coursesProvider.coursesModel;
                    // final filteredCourses = courses
                    //     .where((course) => !course.name.contains("Month"))
                    //     .toList();
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 200,
                        crossAxisCount: 2,
                        crossAxisSpacing: appDefaultSpacing,
                        mainAxisSpacing: appDefaultSpacing,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: courses.length,
                        (context, index) {
                          final course = courses[index];
                          return CourseCard(
                            course: course,
                            onTap: () {
                              try {
                                printIfDebug(course.sections[0].title);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Consumer<CoursesProvider>(
                                    builder: (context, coursesProvider, child) {
                                      // Pass the updated course from the provider here
                                      final course =
                                          coursesProvider.coursesModel[index];
                                      return SectionsScreen(
                                        course: course,
                                      );
                                    },
                                  );
                                }));
                              } catch (e) {
                                showErrorToast("Something went wrong.");
                                rethrow;
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
